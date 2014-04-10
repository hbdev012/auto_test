Feature: Sign in
  As a guest
  I should be able to sign in
  So that I can access restricted areas of the site

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email         | company_name   | role  | confirmed | pending |
      | user@test.com | Planet Express |       | true      | false   |
    And I am not logged in
    And I go to the sign in page

  Scenario: User is not signed up
    Given no user exists with an email of "noexist@test.com"
    And   I sign in as "noexist@test.com/please"
    Then  I should see "Invalid email or password."
    And   I go to the home page
    And   I should be signed out

  Scenario: User enters wrong password
    When I sign in as "user@test.com/wrongpassword"
    Then I should see "Invalid email or password."
    And  I go to the home page
    And  I should be signed out

  Scenario: User signs in successfully with email
    When I sign in as "user@test.com/please"
    Then I should see "Signed in successfully."
    And  I should be signed in
    When I return next time
    Then I should be already signed in
