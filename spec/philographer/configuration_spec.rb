require 'spec_helper'

module Philographer
  describe Configuration do
    let(:config) { Configuration.new }

    describe '#authentication_data' do
      let(:username) { 'myuser@place.com' }
      let(:password) { 'someSecurePasswordThatIsSuperLong' }
      let(:integrator_key) { 'RESE-1108cc9d-b482-4a55-afdc-3511648f47d1' }

      before do
        config.username = username
        config.password = password
        config.integrator_key = integrator_key
      end

      it 'must return a hash of the data ready for incorporation into the HTTP headers' do
        config.authentication_data.must_equal({
          'Username' => username,
          'Password' => password,
          'IntegratorKey' => integrator_key
        })
      end

      it 'must raise an error when the username is missing' do
        config.username = nil
        -> { config.authentication_data }.must_raise Configuration::IncompleteAuthDataError
      end

      it 'must raise an error when the password is missing' do
        config.password = nil
        -> { config.authentication_data }.must_raise Configuration::IncompleteAuthDataError
      end

      it 'must raise an error when the integrator_key is missing' do
        config.integrator_key = nil
        -> { config.authentication_data }.must_raise Configuration::IncompleteAuthDataError
      end
    end

    describe '#environment' do
      it 'must default to demo' do
        config.environment.must_equal 'demo'
      end
    end

    describe '#environment=(env_string)' do
      %w{demo NA1 NA2 EU1}.each do |environment|
        it "must accept '#{environment}' as the setting" do
          config.environment = environment
          config.environment.must_equal environment.upcase
        end
      end

      it 'must raise ArgumentError if something else is passed' do
        -> { config.environment = 'garbage' }.must_raise(ArgumentError)
      end
    end
  end
end
