require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  # config.default_cassette_options = { erb: true, record: :new_episodes }
  config.default_cassette_options = { erb: true }
end

Around '@login_playback' do |scenario, block|
  VCR.use_cassette('login_information') do
    block.call
  end
end

Around '@envelopes' do |scenario, block|
  VCR.use_cassette('envelopes') do
    block.call
  end
end
