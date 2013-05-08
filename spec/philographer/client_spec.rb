require 'spec_helper'

module Philographer
  describe Client do
    let(:client) { Client.new(Philographer.configuration) }

    describe '#domain' do
      let(:config) { Configuration.new }

      Configuration::ENVIRONMENT_OPTIONS.each do |option|
        it "must return a value for #{option}" do
          config.environment = option
          Philographer.stub :configuration, config do
            client.domain.wont_be_nil
          end
        end
      end

      it "must raise an error if an unknown value is set for the environment" do
        -> {
          # I know stubbing on the object under test is bad juju but the config
          # object doesn't allow setting bad values either and this is to ensure
          # the two stay in sync
          client.stub :environment, config do
            client.domain.wont_be_nil
          end
        }.must_raise Client::UnknownEnvironmentOptionError
      end
    end

    describe '#login_information' do
      it "must fetch the login information from docusign and return the instantiated object" do
        login_info = VCR.use_cassette('login_information') {
          client.login_information
        }
        login_info.must_be :is_a?, LoginInformation
      end

      it "must cache the retreived login info for later (re)use" do
        # the caching here is implicit since the cassette only has a single
        # request and we're not recording new ones.
        VCR.use_cassette('login_information') {
          client.login_information
          client.login_information
        }
      end
    end
  end
end
