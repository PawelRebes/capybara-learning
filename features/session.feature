Feature: User Session

  Background:
    Given There exists following users
      | Name               | Password |
      | jill@example.com   | Password |
    And I go to main page
    And I click in navbar "Sign in"

  Scenario: Failed log in
    When I fill "Email" field with "jill@example.com"
    And I fill "user[password]" field with "invalid password"
    And I click button "Sign in"
    Then I should see navigation links for guest user
    And I should see sign in error message

  Scenario: Successful log in
    When I fill "Email" field with "jill@example.com"
    And I fill "user[password]" field with "Password"
    And I click button "Sign in"
    Then I should see navigation links for signed in user
    And I should see welcome message
