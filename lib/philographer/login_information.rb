require 'httpclient/include_client'
module Philographer
  class LoginInformation
    attr_reader :login_accounts

    extend HTTPClient::IncludeClient

    include_http_client

    def self.config
      Philographer.configuration
    end

    def self.domain
      return @domain unless @domain.blank?
      @domain = config.production? ? 'www.docusign.net' : 'demo.docusign.net'
    end

    def self.url
      "https://#{domain}/restapi/v2/login_information"
    end

    def self.request_headers
      {
        'X-DocuSign-Authentication' => config.authentication_data.to_json,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def self.fetch
      @response = http_client.get(url, header: request_headers) if @response.nil?
      new(@response.body)
    end

    def initialize(response_json)
      response = JSON.parse(response_json)
      @login_accounts = response['loginAccounts'].map { |account_data|
        LoginAccount.new(account_data)
      }
    end
  end
end
