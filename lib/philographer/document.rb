module Philographer
  class Document
    attr_accessor :path

    def initialize(path)
      @path = path
    end

    def name
      File.basename(path)
    end

    def file
      return @file if @file.present? && @file.path == path
      @file = File.open(path)
    end
  end
end
