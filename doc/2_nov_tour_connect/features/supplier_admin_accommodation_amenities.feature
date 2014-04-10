Feature: Supplier Admin manage accommodation amenities
  As a Supplier Admin ISBAT manage accommodation amenities

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  Scenario: Specifying accommodation amenities
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    And I select "Babysitting" from "accommodation_amenities"
    And I select "Barbecue" from "accommodation_amenities"
    And I select "Children's Play Area" from "accommodation_amenities"
    And I select "Dry Cleaning" from "accommodation_amenities"
    And I select "Wi-Fi Internet" from "accommodation_amenities"
    And I select "Swimming Pool" from "accommodation_amenities"
    And I select "24 Hour Security" from "accommodation_amenities"
    And  I press "Save & Next"
    Then "Awesome Accommodation" accommodation amenities should have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Dry Cleaning         |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    And I unselect "Dry Cleaning" from "accommodation_amenities"
    And I press "Save & Next"
    Then "Awesome Accommodation" accommodation amenities should have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |
    And "Awesome Accommodation" accommodation amenities should not have the following values:
      | name         |
      | Dry Cleaning |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    And I unselect "Babysitting" from "accommodation_amenities"
    And I unselect "Barbecue" from "accommodation_amenities"
    And I unselect "Children's Play Area" from "accommodation_amenities"
    And I unselect "Dry Cleaning" from "accommodation_amenities"
    And I unselect "Wi-Fi Internet" from "accommodation_amenities"
    And I unselect "Swimming Pool" from "accommodation_amenities"
    And I unselect "24 Hour Security" from "accommodation_amenities"
    And I press "Save & Next"
    Then "Awesome Accommodation" accommodation amenities should not have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Dry Cleaning         |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |

  #   @javascript
  #   Scenario: Adding a custom amenity to the list
  #     Given "Planet Express" has the following amenities:
  # | name        |
  # | Babysitting |
  #     And "Planet Express" has the following accommodations:
  # | name                  |
  # | Awesome Accommodation |
  #     When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
  #     And I fill in "new_amenity" with "New Amenity"
  #     And I follow "Add" within ".new-amenity"
  #     And I wait for the AJAX call to finish
  #     And I select "New Amenity" from "accommodation_amenities"
  #     And I fill in "new_amenity" with "Another Amenity"
  #     And I follow "Add" within ".new-amenity"
  #     And I select "Another Amenity" from "accommodation_amenities"
  #     And I wait for the AJAX call to finish
  #     And I press "Save & Next"
  #     Then "Awesome Accommodation" accommodation amenities should have the following values:
  # | name            |
  # | New Amenity     |
  # | Another Amenity |
  #     And "Awesome Accommodation" accommodation amenities should not have the following values:
  # | name        |
  # | Babysitting |

