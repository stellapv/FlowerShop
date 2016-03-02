Feature: Home page

Scenario: I am not logged in
  Given I am at the home page
  Then I should see "You want to gift love ..."
  And I should see "Log In"