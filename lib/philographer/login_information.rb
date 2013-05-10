require 'singleton'

module Philographer
  class LoginInformation
    include Singleton

    attr_reader :login_accounts

    def self.fetch
      Philographer.client.login_information
    end

    def process_account_data(response)
      @login_accounts = response['loginAccounts'].map { |account_data|
        LoginAccount.new(account_data)
      }
    end

    def default_account
      @default_account ||= login_accounts.select { |account|
        account.is_default
      }.first
    end
  end
end
