require 'spec_helper'

module Philographer
  describe Client do
    let(:client) { Client.new(Philographer.configuration) }


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
