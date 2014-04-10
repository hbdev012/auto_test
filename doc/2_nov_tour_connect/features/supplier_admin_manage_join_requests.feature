Feature: Supplier admin manage join requests
  As a Supplier Admin
  I should be able to manage join requests

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email              | company_name   | role  | confirmed | pending |
      | admin@test.com     | Planet Express | admin | true      | false   |
      | confirmed@test.com | Planet Express |       | true      | false   |
      | pending_1@test.com | Planet Express |       | false     | true    |

  Scenario: Non admin viewing pending requests
    Given I sign in as "confirmed@test.com/please"
    And   I go to the admin users page
    Then  I should be on the homepage
    And   I should see "You are not authorized to access this page."

  Scenario: Supplier Admin viewing pending requests
    Given the following users:
      | email              | company_name   | role  | confirmed | pending |
      | pending_2@test.com | Planet Express |       | false     | true    |
    And  I sign in as "admin@test.com/please"
    And  I follow "Users"
    Then I should see "pending_1@test.com" within "#pending-users"
    And  I should see "pending_2@test.com" within "#pending-users"

  Scenario: Supplier Admin accept pending request
    Given I sign in as "admin@test.com/please"
    And   I follow "Users"
    When  I press "Accept" within "#pending-users"
    Then  I should see "is now a member of the company."
    And   I should not see "pending_1@test.com"
    And   "pending_1@test.com" should receive an email with subject "Confirmation instructions"
    When  "pending_1@test.com" opens the email
    Then  they should not see "Denial Reason:" in the email body
    When  they click the first link in the email
    Then  I should be on the home page
    And   I should see "Your account was successfully confirmed. You are now signed in."

  @javascript
  Scenario: Supplier Admin reject pending request with reason
    Given I sign in as "admin@test.com/please"
    And   I follow "Users"
    When  I press "Reject" within "#pending-users"
    And   I fill in "reason" with "Who is this?"
    And   I press "OK"
    And   I wait for the AJAX call to finish
    And   I should not see "pending_1@test.com"
    And   I should see "has been removed."
    When  "pending_1@test.com" opens the email
    Then  they should see "Who is this?" in the email body
