require_relative 'api_object'

module Philographer
  class EventNotification
    include APIObject

    attribute :url
    attribute :logging_enabled
    attribute :require_acknowledgment
    attribute :include_documents
    attribute :envelope_events
    attribute :sign_message_with_x509_cert

    def initialize(attributes = {})
      super
      self.logging_enabled = false
      self.require_acknowledgment = false
      self.include_documents = false
      self.sign_message_with_x509_cert = true
      self.envelope_events = []
    end
  end
end
