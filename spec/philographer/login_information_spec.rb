require 'spec_helper'

module Philographer
  describe LoginInformation do
    let(:login_info) { LoginInformation.instance }

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

    describe '#default_account' do
      let(:account_data) { {
        'loginAccounts' => [
          {
            "name"=>"Some Company", "accountId"=>"1234",
            "baseUrl"=>"https://demo.docusign.net/restapi/v2/accounts/1234",
            "isDefault"=>"true", "userName"=>"Test User",
            "userId"=>"1215897a-cf21-4703-9b46-16c7900e7ae3", "email"=>"user@test.com",
            "siteDescription"=>"A really descriptive description"
          },
          {
            "name"=>"Another Company", "accountId"=>"123456",
            "baseUrl"=>"https://demo.docusign.net/restapi/v2/accounts/123456",
            "isDefault"=>"false", "userName"=>"Test User",
            "userId"=>"08e35464-9ffb-444c-97d2-978bddef4445", "email"=>"user@test.com",
            "siteDescription"=>"A really descripitive description"
          }
        ]
      } }

      before do
        login_info.process_account_data(account_data)
      end

      it 'must return the LoginAccount instance that is marked as default' do
        account = login_info.default_account
        account.id.must_equal '1234'
      end
    end
  end
end
