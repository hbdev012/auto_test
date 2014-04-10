Feature: Supplier manage accommodations
  As a Supplier ISBAT manage accommodations

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  Scenario: Specifying accommodation classification
    Given "Planet Express" has the following accommodations:
     | name                  |
     | Awesome Accommodation |
    And  I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    When I check "Hotel"
    And  I check "Lodge"
    And  I check "Homestay/Farmstay"
    And  I check "Resort"
    And  I check "Caravan"
    And  I check "Hostel"
    And  I check "Apartments"
    And  I check "Cottages"
    And  I check "Motel"
    And  I check "Bed & Breakfast"
    And  I press "Save & Next"
    Then "Awesome Accommodation" accommodation classifications should have the following values:
      | name              |
      | Hotel             |
      | Lodge             |
      | Homestay/Farmstay |
      | Resort            |
      | Caravan           |
      | Hostel            |
      | Apartments        |
      | Cottages          |
      | Motel             |
      | Bed & Breakfast   |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    Then the "Hotel" checkbox should be checked
    And  the "Lodge" checkbox should be checked
    And  the "Homestay/Farmstay" checkbox should be checked
    And  the "Resort" checkbox should be checked
    And  the "Caravan" checkbox should be checked
    And  the "Hostel" checkbox should be checked
    And  the "Apartments" checkbox should be checked
    And  the "Cottages" checkbox should be checked
    And  the "Motel" checkbox should be checked
    And  the "Bed & Breakfast" checkbox should be checked
    When I uncheck "Caravan"
    And  I press "Save & Next"
    Then "Awesome Accommodation" accommodation classifications should have the following values:
      | name              |
      | Hotel             |
      | Lodge             |
      | Homestay/Farmstay |
      | Resort            |
      | Hostel            |
      | Apartments        |
      | Cottages          |
      | Motel             |
      | Bed & Breakfast   |
    And "Awesome Accommodation" accommodation classifications should not have the following values:
      | name    |
      | Caravan |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    When I uncheck "Hotel"
    And  I uncheck "Lodge"
    And  I uncheck "Homestay/Farmstay"
    And  I uncheck "Resort"
    And  I uncheck "Caravan"
    And  I uncheck "Hostel"
    And  I uncheck "Apartments"
    And  I uncheck "Cottages"
    And  I uncheck "Motel"
    And  I uncheck "Bed & Breakfast"
    And  I press "Save & Next"
    And "Awesome Accommodation" accommodation classifications should not have the following values:
      | name              |
      | Hotel             |
      | Lodge             |
      | Homestay/Farmstay |
      | Resort            |
      | Caravan           |
      | Hostel            |
      | Apartments        |
      | Cottages          |
      | Motel             |
      | Bed & Breakfast   |
