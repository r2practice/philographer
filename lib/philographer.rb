require 'active_support/all'
require "philographer/version"

require "philographer/configuration"
require "philographer/client"
require "philographer/login_information"
require "philographer/login_account"

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

  def self.client
    @client ||= Client.new(configuration)
  end

  def self.client=(client)
    @client = client
  end
end
