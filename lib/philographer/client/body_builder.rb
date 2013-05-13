require 'mime/types'
module Philographer
  class Client
    class BodyBuilder # /flex
      attr_reader :object

      def self.build_for(object)
        builder = new(object)
        builder.build!
      end

      def initialize(object)
        @object = object
      end

      def build!
        if object.respond_to? :documents
          build_multipart(object)
        else
          object.to_json
        end
      end

      def build_multipart(object)
        body = [
          {
            'Content-Type' => 'application/json',
            'Content-Disposition' => 'form-data',
            :content => object.to_json
          }
        ]

        body += object.documents.map { |document|
          file_type = MIME::Types.of(document.path).first
          {
            'Content-Type' => file_type.to_s,
            'Content-Disposition' => "file; filename=\"#{document.name}\"; documentId=#{document.id}",
            :content => document.file
          }
        }

        body
      end
    end
  end
end
