require 'active_support/all'
require "philographer/version"

%w{configuration document envelope tab template template_role recipient
login_information login_account}.each do |file|
  require "philographer/#{file}"
end

require "philographer/client"

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
