require 'spec_helper'

module Philographer
  describe Recipient do
    let(:recipient) { Recipient.new }

    describe '#initialize' do
      it 'must have a default value for tabs of []' do
        recipient.tabs.must_equal []
      end
    end


    describe '#json_type' do
      it 'must raise an error indicating the recipient type is missing' do
        -> { recipient.json_type }.must_raise Recipient::NoTypeSetError
      end

      it 'must camelcase and pluralize the type' do
        recipient.type = :carbon_copy
        recipient.json_type.must_equal 'carbonCopies'
      end
    end
  end
end
