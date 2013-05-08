require 'spec_helper'

module Philographer
  describe Recipient do
    let(:recipient) { Recipient.new }

    describe '#initialize' do
      it 'must have a default value for tabs of []' do
        recipient.tabs.must_equal []
      end
    end
  end
end
