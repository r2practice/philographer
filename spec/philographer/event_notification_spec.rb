require 'spec_helper'

module Philographer
  describe EventNotification do
    let(:notification) { EventNotification.new }

    describe '#initialze(attributes = {})' do
      it 'must default logging_enabled to false' do
        notification.wont_be :logging_enabled
      end

      it 'must default require_acknowledgment to false' do
        notification.wont_be :require_acknowledgment
      end

      it 'must default include_documents to false' do
        notification.wont_be :include_documents
      end

      it 'must default sign_message_with_x509_cert to true' do
        notification.must_be :sign_message_with_x509_cert
      end

      it 'must default envelope_events to an array' do
        notification.envelope_events.must_equal []
      end
    end
  end
end
