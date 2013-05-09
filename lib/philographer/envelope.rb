require_relative 'api_object'

module Philographer
  class Envelope
    include APIObject
    attribute :status, required: true
    attribute :accessibility
    attribute :allow_markup
    attribute :allow_reassign
    attribute :allow_recipient_recursion
    attribute :asynchronous
    attribute :authoritative_copy
    attribute :auto_navigation
    attribute :brand_id
    attribute :composite_templates
    attribute :custom_fields
    attribute :documents#, required: ->(envelope) { envelope.template_id.blank? }, type: Document
    attribute :email_blurb
    attribute :email_subject, required: true
    attribute :enable_wet_sign
    attribute :enforce_signer_visibility
    attribute :envelope_id_stamping
    attribute :event_notification#, type: EventNotification
    attribute :message_locked
    attribute :recipients#, type: Recipient
    attribute :signing_location
    attribute :template_id
    attribute :template_roles#, required: ->(envelope) { envelope.template_id.present? }, type: Recipient

    def initialize(attributes = {})
      super
      self.status ||= 'created'
      self.documents ||= []
      self.recipients ||= []
    end

    def save
      Client.post(self)
    end
  end
end
