Feature: Supplier admin manage accommodations
  As a supplier admin ISBAT manage accommodation properties  As a role

  Background:
    Given the following companies:
      | name             | _type      | country       |
      | Planet Express   | Supplier   | United States |
      | Super Contractor | Contractor | United States |
    Given the following users:
      | email               | company_name     | role  | confirmed | pending |
      | admin@test.com      | Planet Express   | admin | true      | false   |
      | contractor@test.com | Super Contractor | admin | true      | false   |
    Given "Planet Express" has the following accommodations:
      | name                    |
      | Awesome Accommodation   |
      | Awesome Accommodation 1 |
      | Awesome Accommodation 2 |
    Given "Planet Express" has the following non accommodations:
      | name                |
      | Non Accommodation   |
      | Non Accommodation 1 |
      | Non Accommodation 2 |
    And "Planet Express" has valid billing information

  Scenario: Contractor Admin cannot see link to view all accommodations
    Given I sign in as "contractor@test.com/please"
    When I am on the home page
    Then I should not see "Accommodations"

  Scenario: Contractor Admin user cannot view accommodations
  Given I sign in as "contractor@test.com/please"
    And   I go to the admin accommodations page
    Then  I should see "Access Denied"

  Scenario: Displaying a link to view all accommodations
    Given I sign in as "admin@test.com/please"
    When I am on the home page
    And I follow "Accommodations"
    Then I should be on the admin accommodations page

  Scenario: Displaying a link to add a new accommodation
    Given I sign in as "admin@test.com/please"
    When I am on the admin accommodations page
    And I follow "New Accommodation"
    Then I should be on the new admin accommodation page

  Scenario: Viewing all accommodations
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodations page
    Then I should see "Awesome Accommodation"
    Then I should see "Awesome Accommodation 1"
    Then I should see "Awesome Accommodation 2"
    And I should not see "Non Accommodation"
    And I should not see "Non Accommodation 1"
    And I should not see "Non Accommodation 2"

  Scenario: Accommodation names should be links to edit
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodations page
    When I follow "Awesome Accommodation"
    Then I should be on the edit admin "Awesome Accommodation" accommodation page
    And I should see "Step One: Basic Information"

  Scenario: Removing accommodations
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodations page
    Then the "Delete" link should have confirmation within "#accommodations li:nth-child(3)"
    When I follow "Delete" within "#accommodations li:nth-child(3)"
    Then I should see "Accommodation deleted"
    And I should not see "Awesome Accommodation 2"
