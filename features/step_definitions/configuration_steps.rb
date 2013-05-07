When(/^the file "(.*?)" has been required$/) do |file_path|
  path = File.expand_path("../../../tmp/aruba/#{file_path}", __FILE__)
  require path
end

Then(/^the user's config values should be stored$/) do
  config = Philographer.configuration
  config.username.must_equal 'myuser@test.com'
  config.password.must_equal 'someSuperSecurePasswordThatNo1CouldEverGuess'
  config.integrator_key.must_equal "RESE-1108cc9d-b482-4a55-afdc-3511648f47d1"
end

Then(/^the user's authentication data should be ready for submission to DocuSign$/) do
  expected_hash = {
    'Username' => 'myuser@test.com',
    'Password' => 'someSuperSecurePasswordThatNo1CouldEverGuess',
    'IntegratorKey' => "RESE-1108cc9d-b482-4a55-afdc-3511648f47d1"
  }
  Philographer.configuration.authentication_data.must_equal expected_hash
end

Given(/^a (mostly|fully) configured user account$/) do |config_level|
  load_credentials((config_level == 'fully'))
end
