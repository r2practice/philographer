require 'spec_helper'

module Philographer
  describe Template do
    let(:template) { Template.new }

    describe '#initialize(attributes = {})' do
      it 'must default recipients to an array' do
        template.recipients.must_equal []
      end

      it 'must default documents to an array' do
        template.documents.must_equal []
      end
    end
  end
end
