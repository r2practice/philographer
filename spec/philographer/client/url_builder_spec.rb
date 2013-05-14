require 'spec_helper'

module Philographer
  class Client
    describe URLBuilder do

      let(:config) {
        Configuration.new
      }

      let(:builder) { URLBuilder.new(config, Class.new) }

      describe '.login_url(config)' do
        let(:url) { URLBuilder.login_url(config) }

        it 'must return the login information for the specified environment' do
          url.must_equal "https://demo.docusign.net/restapi/v2/login_information"
        end
      end

      describe '#base_url' do
        describe "when the account id is unknown" do
          before do
            # load up our credentials excluding the account_id
            URLBuilder.base_url = nil
            load_credentials(false)
          end

          it "must ask the login info for the default account's id" do
            url = VCR.use_cassette('login_information') {
              builder.base_url
            }
            url.must_match /\/accounts\/1234\/$/
          end

          it "must set the config object's account_id attribute with the found value" do
            url = VCR.use_cassette('login_information') {
              builder.base_url
            }
            config.account_id.must_equal '1234'
          end
        end

        describe 'with a known account id' do
          before do
            URLBuilder.base_url = nil
            config.account_id = 'REGEX_ME'
          end

          it 'must return a url with the correct domain' do
            builder.base_url.must_match /^https:\/\/demo.docusign.net\//
          end

          it 'must return a url with the specified account number' do
            builder.base_url.must_match /\/accounts\/REGEX_ME\/$/
          end

          it 'must include the api specification' do
            builder.base_url.must_match /\/restapi\/v2\//
          end
        end
      end

      describe '#build!' do
        before do
          config.account_id = '12345'
        end

        it 'must return the correct url for an envelope' do
          builder = URLBuilder.new(config, Philographer::Envelope)
          url = builder.build!
          url.must_match /\/envelopes$/
        end

        it 'must return the correct url for a template' do
          builder = URLBuilder.new(config, Philographer::Template)
          url = builder.build!
          url.must_match /\/templates$/
        end
      end
    end
  end
end
