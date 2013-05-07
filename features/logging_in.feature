Feature: Retreiving Login and Account information

  Getting a user's account information so we can make further
  requests to the DocuSign API.

  @login_playback
  Scenario: Retreiving and storing the user's login account data
    Given a mostly configured user account
    When I have requested the information on login accounts
    Then I should have received the account information and cached it
