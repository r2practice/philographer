module Philographer
  class Client
    class URLBuilder
      class UnknownEnvironmentOptionError < StandardError; end

      DOMAIN_MAP = {
        'DEMO' => 'demo.docusign.net',
        'NA1' => 'www.docusign.net',
        'NA2' => 'na2.docusign.net',
        'EU1' => 'eu1.docusign.net'
      }

      class << self
        attr_accessor :base_url
      end

      attr_reader :object, :config

      def self.url_for(config, object)
        builder = new(config, object)
        builder.build!
      end

      def self.login_url(config)
        return @login_url if @login_url.present?
        builder = new(config)
        @login_url = "https://#{builder.domain}/restapi/v2/login_information"
      end

      def initialize(config, object = nil)
        @config = config
        @object = object
      end

      def build!
        if object.is_a? Envelope
          base_url + "envelopes/#{object.id}"
        end
      end

      def base_url
        self.class.base_url ||= "https://#{domain}/restapi/v2/accounts/#{account_id}/"
      end

      def domain
        DOMAIN_MAP.fetch(config.environment) {
          raise UnknownEnvironmentOptionError.new("#{config.environment} has no domain name associated with it.")
        }
      end

      def account_id
        return @account_id if @account_id.present?
        return @account_id = config.account_id if config.account_id.present?

        login_info = LoginInformation.fetch
        account = login_info.default_account
        config.account_id = account.id
        @account_id = account.id
      end
    end
  end
end
