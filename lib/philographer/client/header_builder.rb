module Philographer
  class Client
    module HeaderBuilder
      def self.headers_for(config, object)
        if object.respond_to?(:documents) && object.documents.present?
          base_headers(config).merge({'Content-Type' => 'multipart/form-data'})
        else
          base_headers(config).merge('Content-Type' => 'application/json')
        end
      end

      def self.base_headers(config)
        @base_heders ||= {
          'X-DocuSign-Authentication' => config.authentication_data.to_json,
          'Accept' => 'application/json',
        }
      end
    end
  end
end
