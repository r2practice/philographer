require_relative 'api_object'

module Philographer
  class Document
    include APIObject

    attr_accessor :path
    attribute :name
    attribute :pdf_bytes
    attribute :attachment_description
    attribute :path

    def file
      return @file if @file.present? && @file.path == path
      @file = File.open(path)
    end

    def name
      return @name if @name.present?
      if path.present?
        @name = File.basename(path)
      else
        nil
      end
    end
  end
end
