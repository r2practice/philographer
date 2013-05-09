module Philographer
  class Configuration

    class IncompleteAuthDataError < StandardError; end

    attr_accessor :account_id, :integrator_key, :password, :username

    def authentication_data
      return @authentication_data if @authentication_data
      if username.present? && password.present? && integrator_key.present?
        @authentication_data = {
          'Username' => username,
          'Password' => password,
          'IntegratorKey' => integrator_key
        }
      else
        raise IncompleteAuthDataError.new("All authorization fields (username, password, integrator_key) are required for authentication to DocuSign")
      end
    end

    def environment
      @environment ||= 'DEMO'
    end

    ENVIRONMENT_OPTIONS = %w{DEMO NA1 NA2 EU1}
    def environment=(env)
      environment = env.to_s.upcase
      unless ENVIRONMENT_OPTIONS.include? environment
        raise ArgumentError.new("Environment setting invalid! Allowed values are: #{ENVIRONMENT_OPTIONS.join(', ')}")
      else
        @environment = environment
      end
    end
  end
end
