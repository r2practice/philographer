require 'active_support/all'
require "philographer/version"
require "philographer/configuration"

module Philographer
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration if block_given?
  end
end
