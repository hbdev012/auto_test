Feature: Supplier admin manage non accommodation products
  As a supplier admin ISBAT manage non accommodation properties  As a role

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
    And "Awesome Accommodation" has the following products:
      | name                            | _type                |
      | Awesome Accommodation Product   | AccommodationProduct |
      | Awesome Accommodation Product 1 | AccommodationProduct |
      | Awesome Accommodation Product 2 | AccommodationProduct |
    And "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
      | Another Non Accommodation |
    And "Awesome Non Accommodation" has the following products:
      | name                        | _type                   |
      | Non Accommodation Product   | NonAccommodationProduct |
      | Non Accommodation Product 1 | NonAccommodationProduct |
    And "Another Non Accommodation" has the following products:
      | name                        | _type                   |
      | Non Accommodation Product 2 | NonAccommodationProduct |

  Scenario: Contractor Admin cannot see link to view all non accommodation products
    Given I sign in as "contractor@test.com/please"
    When  I am on the home page
    Then  I should not see "Non-Accommodation Products"

  Scenario: Contractor Admin user cannot view non accommodation products
    Given I sign in as "contractor@test.com/please"
    And   I go to the admin non accommodation products page
    Then  I should see "Access Denied"

  Scenario: Displaying a link to view all non accommodation products
    Given I sign in as "admin@test.com/please"
    When  I am on the home page
    And   I follow "Non-Accommodation Products"
    Then  I should be on the admin non accommodation products page

  Scenario: Displaying a link to add a new non accommodation product
    Given I sign in as "admin@test.com/please"
    When  I am on the admin non accommodation products page
    And   I follow "New Non-Accommodation Product"
    Then  I should be on the new admin non accommodation product page

  Scenario: Viewing all non accommodations
    Given I sign in as "admin@test.com/please"
    And   I am on the admin non accommodation products page
    Then  I should see "Non Accommodation Product"
    And   I should see "Non Accommodation Product 1"
    And   I should see "Non Accommodation Product 2"
    And   I should not see "Awesome Accommodation Product"
    And   I should not see "Awesome Accommodation Product 1"
    And   I should not see "Awesome Accommodation Product 2"

  Scenario: Viewing filtered non accommodations
    Given I sign in as "admin@test.com/please"
    And   I am on the admin non accommodation products page
    When  I select "Awesome Non Accommodation" from "Filter by:"
    And   I press "Filter"
    Then  I should see "Non Accommodation Product"
    And   I should see "Non Accommodation Product 1"
    And   I should not see "Non Accommodation Product 2"

  Scenario: Accommodation product names should be links to edit
    Given I sign in as "admin@test.com/please"
    Given I am on the admin non accommodation products page
    When  I follow "Non Accommodation Product"
    Then  I should be on the edit admin non accommodation "Non Accommodation Product" product page
    And   I should see "Step One: Basic Information"

  Scenario: Removing non accommodation product
    Given I sign in as "admin@test.com/please"
    Given I am on the admin non accommodation products page
    Then  the "Delete" link should have confirmation within "#non-accommodation-products li:nth-child(3)"
    When  I follow "Delete" within "#non-accommodation-products li:nth-child(3)"
    Then  I should not see "Non Accommodation Product 2"
