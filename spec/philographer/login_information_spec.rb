require 'spec_helper'

module Philographer
  describe LoginInformation do

    describe '.domain' do

      before do
        LoginInformation.instance_variable_set(:@domain, nil) # bust our cache
      end

      describe "when the config's environment is demo" do
        # config defaults to demo environment
        it 'must return the demo domain' do
          LoginInformation.domain.must_equal 'demo.docusign.net'
        end
      end

      describe "when the config's environment is production" do
        it 'must return the production domain' do
          Philographer.configuration.environment = 'production'
          LoginInformation.domain.must_equal 'www.docusign.net'
        end
      end
    end

    describe '.fetch' do
      let(:login_info) {
        VCR.use_cassette('login_information') {
          LoginInformation.fetch
        }
      }

      before do
        LoginInformation.instance_variable_set(:@domain, nil) # bust our cache
      end

      it 'must be awesomely fast' do
        login_info.login_accounts.size.must_equal 2
      end
    end
  end
end
