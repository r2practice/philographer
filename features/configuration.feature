Feature: Configuring Philographer

  Providing required settings to determine how to interface with DocuSign

  Scenario: Setting the user's config
    Given a file named "features/support/philographer_config.rb" with:
    """ruby
    require 'philographer'

    Philographer.configure do |config|
      config.username = "myuser@test.com"
      config.password = "someSuperSecurePasswordThatNo1CouldEverGuess"
      config.integrator_key = "RESE-1108cc9d-b482-4a55-afdc-3511648f47d1"
    end
    """
    When the file "features/support/philographer_config" has been required
    Then the user's config values should be stored
    And the user's authentication data should be ready for submission to DocuSign
