Feature: Sign out
  As a user
  I should be able to sign out
  So that I can protect my account access

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email         | company_name   | role  | confirmed | pending |
      | user@test.com | Planet Express |       | true      | false   |
    And I am not logged in
    And I go to the sign in page
    And I sign in as "user@test.com/please"

  @javascript
  Scenario: User signs out
    When I sign out
    Then I should see "Signed out"
    When I return next time
    Then I should be signed out
