require 'spec_helper'

module Philographer
  describe TemplateRole do
    let(:role) { TemplateRole.new }

    describe '#initialize(attributes = {})' do
      it 'must default tabs to []' do
        role.tabs.must_equal []
      end
    end
  end
end
