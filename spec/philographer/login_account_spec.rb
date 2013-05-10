require 'spec_helper'

module Philographer
  describe LoginAccount do
    describe '#is_default' do
      it 'must return true when the attributes has the string "true"' do
        account = LoginAccount.new({'isDefault' => "true"})
        account.must_be :is_default
      end

      it 'must return false when the attribute is the string "false"' do
        account = LoginAccount.new({'isDefault' => "false"})
        account.wont_be :is_default
      end
    end

    describe '#id' do
      let(:id) { SecureRandom.uuid }
      let(:account) { LoginAccount.new('accountId' => id) }

      it 'must return the accountId attribute from DocuSign' do
        account.id.must_equal id
      end
    end
  end
end
