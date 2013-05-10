require_relative 'api_object'

module Philographer
  class Recipient
    include APIObject

    class NoTypeSetError < StandardError; end

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

    def json_type
      raise NoTypeSetError.new("Recipients must have a type set before they can be serialized for submission to DocuSign") unless type.present?
      type.to_s.pluralize.camelize(:lower)
    end
  end
end

=begin
<s:enumeration value="Signer" />
<s:enumeration value="Agent" />
<s:enumeration value="Editor" />
<s:enumeration value="Intermediary" />
<s:enumeration value="CarbonCopy" />
<s:enumeration value="CertifiedDelivery" />
<s:enumeration value="InPersonSigner" />
=end
