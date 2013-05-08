require 'httpclient/include_client'

module Philographer
  class Client
    extend HTTPClient::IncludeClient
    include_http_client

    class UnknownEnvironmentOptionError < StandardError; end

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

    DOMAIN_MAP = {
      'DEMO' => 'demo.docusign.net',
      'NA1' => 'www.docusign.net',
      'NA2' => 'na2.docusign.net',
      'EU1' => 'eu1.docusign.net'
    }
    def domain
      DOMAIN_MAP.fetch(environment) {
        raise UnknownEnvironmentOptionError.new("#{environment} has no domain name associated with it.")
      }
    end

    def environment
      config.environment
    end

    def login_information
      return @login_information if @login_information
      response = http_client.get("https://#{domain}/restapi/v2/login_information", header: base_headers.merge('Content-Type' => 'application/json'))
      account_data = JSON.parse(response.body)
      @login_information = LoginInformation.instance
      @login_information.process_account_data(account_data)
      @login_information
    end
  end
end
