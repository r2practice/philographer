require 'spec_helper'

module Philographer
  describe LoginInformation do

    describe '.fetch' do
      let(:login_info) {
        VCR.use_cassette('login_information') {
          LoginInformation.fetch
        }
      }

      it 'must be awesomely fast' do
        login_info.login_accounts.size.must_equal 2
      end
    end
  end
end
