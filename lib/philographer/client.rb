require 'httpclient/include_client'

require_relative 'client/url_builder'
require_relative 'client/header_builder'
require_relative 'client/body_builder'

module Philographer
  class Client
    extend HTTPClient::IncludeClient
    include_http_client

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

    def post(object)
      url = URLBuilder.url_for(config, object)
      headers = HeaderBuilder.headers_for(config, object)
      body = BodyBuilder.build_for(object)
      response = http_client.post(url, body: body, header: headers)
      nil
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
  end
end
