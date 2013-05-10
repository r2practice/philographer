require_relative 'api_object'

module Philographer
  class Tab
    include APIObject

    class NoTypeSetError < StandardError; end

    attribute :document_id
    attribute :page_number
    attribute :type
    attribute :x_position
    attribute :y_position

    def json_type
      raise NoTypeSetError.new("Tabs must have a type set before they can be serialized for submission to DocuSign") unless type.present?
      "#{type}_tabs".camelize(:lower)
    end
  end
end
=begin
<s:enumeration value="InitialHere" />
<s:enumeration value="SignHere" />
<s:enumeration value="FullName" />
<s:enumeration value="FirstName" />
<s:enumeration value="LastName" />
<s:enumeration value="EmailAddress" />
<s:enumeration value="Company" />
<s:enumeration value="Title" />
<s:enumeration value="DateSigned" />
<s:enumeration value="InitialHereOptional" />
<s:enumeration value="EnvelopeID" />
<s:enumeration value="Custom" />
<s:enumeration value="SignerAttachment" />
<s:enumeration value="SignHereOptional" />
<s:enumeration value="Approve" />
<s:enumeration value="Decline" />
=end
