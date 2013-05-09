require_relative 'api_object'

module Philographer
  class Recipient
    include APIObject

    attribute :email
    attribute :id
    attribute :name
    attribute :recipient_id
    attribute :tabs
    attribute :type
    attribute :role_name

    def initialize(attributes = {})
      super
      self.tabs ||= []
    end
  end
end
