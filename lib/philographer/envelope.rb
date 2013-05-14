require_relative 'api_object'

module Philographer
  class Envelope
    include APIObject
    attribute :accessibility
    attribute :allow_markup
    attribute :allow_reassign
    attribute :allow_recipient_recursion
    attribute :asynchronous
    attribute :authoritative_copy
    attribute :auto_navigation
    attribute :brand_id
    attribute :certificate_uri
    attribute :composite_templates
    attribute :custom_fields
    attribute :custom_fields_uri
    attribute :documents#, required: ->(envelope) { envelope.template_id.blank? }, type: Document
    attribute :documents_combined_uri
    attribute :documents_uri
    attribute :email_blurb
    attribute :email_subject, required: true
    attribute :enable_wet_sign
    attribute :enforce_signer_visibility
    attribute :envelope_id_stamping
    attribute :event_notification#, type: EventNotification
    attribute :message_locked
    attribute :notification_uri
    attribute :recipients#, type: Recipient
    attribute :recipients_uri
    attribute :signing_location
    attribute :status, required: true
    attribute :status_changed_date_time
    attribute :templates_uri
    attribute :template_id
    attribute :template_roles#, required: ->(envelope) { envelope.template_id.present? }, type: Recipient

    def self.fetch(params = {})
      data = Philographer.client.get(self, params)
      data['envelopes'].map{ |envelope_data| new(envelope_data) }
    end

    def initialize(attributes = {})
      super
      self.status ||= 'created'
      self.documents ||= []
      self.recipients ||= []
      self.template_roles ||= []
    end
  end
end
