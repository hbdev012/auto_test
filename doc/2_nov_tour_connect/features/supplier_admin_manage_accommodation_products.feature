Feature: Supplier admin manage accommodation products
  As a supplier admin ISBAT manage accommodation properties  As a role

  Background:
    Given the following companies:
      | name             | _type      | country       |
      | Planet Express   | Supplier   | United States |
      | Super Contractor | Contractor | United States |
    And "Planet Express" has valid billing information
    And the following users:
      | email               | company_name     | role  | confirmed | pending |
      | admin@test.com      | Planet Express   | admin | true      | false   |
      | contractor@test.com | Super Contractor | admin | true      | false   |
    And "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
      | Another Accommodation |
    And "Awesome Accommodation" has the following products:
      | name                    | _type                |
      | Accommodation Product   | AccommodationProduct |
      | Accommodation Product 1 | AccommodationProduct |
    And "Another Accommodation" has the following products:
      | name                    | _type                |
      | Accommodation Product 2 | AccommodationProduct |
    And "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following products:
      | name                        | _type                   |
      | Non Accommodation Product   | NonAccommodationProduct |
      | Non Accommodation Product 2 | NonAccommodationProduct |
      | Non Accommodation Product 3 | NonAccommodationProduct |

  Scenario: Contractor Admin cannot see link to view all accommodation products
    Given I sign in as "contractor@test.com/please"
    When  I am on the home page
    Then  I should not see "Accommodation Products"

  Scenario: Contractor Admin user cannot view accommodation products
    Given I sign in as "contractor@test.com/please"
    And   I go to the admin accommodation products page
    Then  I should see "Access Denied"

  Scenario: Displaying a link to view all accommodation products
    Given I sign in as "admin@test.com/please"
    When  I am on the home page
    And   I follow "Accommodation Products"
    Then  I should be on the admin accommodation products page

  Scenario: Displaying a link to add a new accommodation product
    Given I sign in as "admin@test.com/please"
    When  I am on the admin accommodation products page
    And   I follow "New Accommodation Product"
    Then  I should be on the new admin accommodation product page

  Scenario: Viewing all accommodations
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodation products page
    Then  I should see "Accommodation Product"
    Then  I should see "Accommodation Product 1"
    Then  I should see "Accommodation Product 2"
    And   I should not see "Non Accommodation Product"
    And   I should not see "Non Accommodation Product 1"
    And   I should not see "Non Accommodation Product 2"

  Scenario: Viewing filtered accommodations
    Given I sign in as "admin@test.com/please"
    And   I am on the admin accommodation products page
    When  I select "Awesome Accommodation" from "Filter by:"
    And   I press "Filter"
    Then  I should see "Accommodation Product"
    And   I should see "Accommodation Product 1"
    And   I should not see "Accommodation Product 2"

  Scenario: Accommodation product names should be links to edit
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodation products page
    When  I follow "Accommodation Product"
    Then  I should be on the edit admin accommodation "Accommodation Product" product page
    And   I should see "Step One: Basic Information"

  Scenario: Removing accommodation product
    Given I sign in as "admin@test.com/please"
    Given I am on the admin accommodation products page
    Then  the "Delete" link should have confirmation within "#accommodation-products li:nth-child(3)"
    When  I follow "Delete" within "#accommodation-products li:nth-child(3)"
    Then  I should not see "Accommodation Product 2"
