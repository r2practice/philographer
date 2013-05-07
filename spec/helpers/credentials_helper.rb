require 'yaml'

module CredentialsHelper
  @credentials_loaded = false

  def load_credentials(include_account_id = false)
    unless CredentialsHelper.credentials_loaded
      begin
        path = File.expand_path('../../credentials.yml', __FILE__)
        credentials = File.open(path) do |f|
          YAML.load(f.read)
        end

        Philographer.configure do |config|
          config.username = credentials['username']
          config.password = credentials['password']
          config.integrator_key = credentials['integrator_key']
          config.account_id = credentials['account_id'] if include_account_id
        end
      rescue Errno::ENOENT

        Philographer.configure do |config|
          config.username = 'SomeUniqueIdentifier'
          config.password = 'AStrongPassword'
          config.integrator_key = 'Integrator-key-with-dashes-n-stuff'
          config.account_id = 123456 if include_account_id
        end
        puts "No Credentials file found! Please create one if you need to hit the real API."
      ensure
        CredentialsHelper.credentials_loaded = true
      end
    end
  end

  def credentials_loaded
    CredentialsHelper.credentials_loaded
  end

  def credentials_loaded=(val)
    CredentialsHelper.credentials_loaded
  end

  def CredentialsHelper.credentials_loaded
    @credentials_loaded
  end

  def CredentialsHelper.credentials_loaded=(val)
    @credentials_loaded = val
  end
end
