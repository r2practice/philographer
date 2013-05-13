require_relative 'api_object'

module Philographer
  class TemplateRole
    include APIObject

    attribute :email
    attribute :name
    attribute :role_name
    attribute :client_user_id
    attribute :default_recipient
    attribute :access_code
    attribute :email_notification
    attribute :tabs

    def initialize(attributes = {})
      super

      self.tabs ||= []
    end
  end
end
