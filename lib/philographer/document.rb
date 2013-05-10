require_relative 'api_object'

module Philographer
  class Document
    include APIObject

    attr_accessor :path
    attribute :id
    attribute :name
    attribute :pdf_bytes
    attribute :attachment_description

    def initialize(path)
      if path.is_a? Hash
        super
      else
        @path = path
      end
    end

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
