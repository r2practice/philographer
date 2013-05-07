When(/^I have requested the information on login accounts$/) do
  Philographer::LoginInformation.fetch
end

Then(/^I should have received the account information and cached it$/) do
  # VCR is set to only allow this request once so the cache check is implicit
  info = Philographer::LoginInformation.fetch
  info.login_accounts.size.must_equal 2
end
