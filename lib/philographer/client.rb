require 'httpclient'
require 'httpclient/include_client'

require_relative 'client/url_builder'
require_relative 'client/header_builder'
require_relative 'client/body_builder'

module Philographer
  class Client
    extend HTTPClient::IncludeClient
    include_http_client

    class BadRequestError < StandardError; end

    attr_reader :config

    def initialize(configuration)
      @config = configuration
    end

    def base_headers
      return @base_headers if @base_headers.present?
      @base_heders = {
        'X-DocuSign-Authentication' => config.authentication_data.to_json,
        'Accept' => 'application/json',
      }
    end

    def environment
      config.environment
    end

    def get(type, params = {})
      params = params.with_indifferent_access
      url = URLBuilder.url_for(config, type, params)
      headers = HeaderBuilder.headers_for(config, type)

      id_free = params.inject(HashWithIndifferentAccess.new) { |query, val|
        unless val[0] == 'id'
          key = val[0].underscore
          query[key] = format_value(val[1])
        end
        query
      }
      response = http_client.get(url, query: id_free, header: headers)
      handle_response(response)
    end

    def post(object)
      url = URLBuilder.url_for(config, object.class)
      headers = HeaderBuilder.headers_for(config, object)
      body = BodyBuilder.build_for(object)

      response = http_client.post(url, body: body, header: headers)
      handle_response(response)
    end

    def login_information
      return @login_information if @login_information
      url = URLBuilder.login_url(config)
      response = http_client.get(url, header: base_headers.merge('Content-Type' => 'application/json'))
      account_data = JSON.parse(response.body)
      @login_information = LoginInformation.instance
      @login_information.process_account_data(account_data)
      @login_information
    end

    private

    def format_value(val)
      if val.respond_to? :iso8601
        val.iso8601
      else
        val
      end
    end

    def handle_failure(response)
      body = JSON.parse(response.body)
      raise BadRequestError.new("#{body['errorCode']}: #{body['message']}")
    end

    def handle_response(response)
      if (200..206).include? response.code
        JSON.parse(response.body)
      else
        handle_failure(response)
      end
    end
  end
end
