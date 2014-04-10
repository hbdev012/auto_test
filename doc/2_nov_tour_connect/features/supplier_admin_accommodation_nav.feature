Feature: Supplier admin accommodation navigation
  As a Supplier Admin ISBAT navigate within an accommodation

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  @javascript
  Scenario: New Accommodation Navigation
    When I am on the new admin accommodation page
    And I follow "Property Description and Location"
    And I follow "Contacts"

  @javascript
  Scenario: Edit Accommodation Navigation
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And I am on the "basic_information" step of the edit admin "Awesome Accommodation" accommodation page
    When I follow "Basic Information"
    Then I should see "Step One: Basic Information"
    And I follow "Property Description and Location"
    And I follow "Contacts"

    And I follow "Ratings and Amenities"
    Then I should see "Step Two: Ratings and Amenities"

    And I follow "Policies"
    Then I should see "Step Three: Policies"

    And I follow "Seasons"
    Then I should see "Step Four: Seasons"

    And I follow "Special Offers"
    Then I should see "Step Five: Special Offers"

    And I follow "Stay/Pay Deals"
    And I follow "Room Upgrades"
    And I follow "Bonus Offers"

    And I follow "Transfer"
    Then I should see "Step Six: Transfer"

    And I follow "Contracts and Billing"
    Then I should see "Step Six: Contracts and Billing"
    And I follow "Property Insurance"
    And I follow "Property Billing Information"
    And I follow "Property Terms and Conditions"

  Scenario: Viewing last saved date on new page
    Given I am on the new admin accommodation page
    Then  I should see "Last Save: Never"

  Scenario: Viewing last saved date on edit page
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And  I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    Then I should see "Last Save: less than a minute ago"

