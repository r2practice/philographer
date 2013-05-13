require 'spec_helper'

module Philographer
  describe Envelope do
    let(:envelope) { Envelope.new }

    describe '#initialize' do
      it 'must set the status to the default of "created"' do
        envelope.status.must_equal 'created'
      end

      it 'must set documents to the default of []' do
        envelope.documents.must_equal []
      end

      it 'must set the recipients to the default of []' do
        envelope.recipients.must_equal []
      end

      it 'must set the template_roles to the default of []' do
        envelope.recipients.must_equal []
      end

      describe 'with an attributes hash supplied' do
        let(:envelope) {
          Envelope.new({
            status: 'sent',
            signing_location: 'InPerson'
          })
        }

        it 'must set the attributes as specified in the hash' do
          envelope.status.must_equal 'sent'
          envelope.signing_location.must_equal 'InPerson'
        end
      end
    end
  end
end
