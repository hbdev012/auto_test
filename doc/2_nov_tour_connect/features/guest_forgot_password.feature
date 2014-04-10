Feature: Password recovery
  As a guest
  I should be able to request a password reset
  So that I can update my password and access the site

  Scenario: Forgot password (does not exist)
    Given I am not logged in
    And   no user exists with an email of "user@test.com"
    When  I go to the sign in page
    And   I follow "Forgot your password?"
    And   I fill in "Email" with "user@test.com"
    And   I press "Send me reset password instructions"
    Then  I should see "Email not found"

  Scenario: Forgot password
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email         | company_name   | role  | confirmed | pending |
      | user@test.com | Planet Express |       | true      | false   |
    And   I am not logged in
    When  I go to the sign in page
    And   I follow "Forgot your password?"
    And   I fill in "Email" with "user@test.com"
    And   I press "Send me reset password instructions"
    Then  I should see "You will receive an email with instructions about how to reset your password in a few minutes."
