Feature: Edit User Profile
  As a user
  I should be able to edit my profile
  So that I can update my info

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
    And I follow "Edit account"

  Scenario: I sign in and edit my account
    When I fill in "First name" with "Foo"
    And  I fill in "Last name" with "Bar"
    And  I press "Update"
    And  I follow "Edit account"
    Then the "First name" field should contain "Foo"
    And  the "Last name" field should contain "Bar"

  Scenario: I sign in and edit my password
    When I fill in "Password" with "thankyou"
    And  I fill in "Password confirmation" with "thankyou"
    And  I press "Update"
    And  I sign out
    When I sign in as "user@test.com/thankyou"
    Then I should be signed in

  Scenario: I sign in and edit my account (invalid)
    When I fill in "First name" with ""
    And  I fill in "Last name" with ""
    When I press "Update"
    Then I should see "First name can't be blank"
    And  I should see "Last name can't be blank"