require 'spec_helper'

module Philographer
  describe Tab do
    let(:tab) { Tab.new }

    describe '#json_type' do
      it 'must raise an error indicating the tab type is missing' do
        -> { tab.json_type }.must_raise Tab::NoTypeSetError
      end

      it 'must camelcase and append tabs to the type' do
        tab.type = :sign_here
        tab.json_type.must_equal 'signHereTabs'
      end
    end
  end
end
