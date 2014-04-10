Feature: Supplier admin accommodation product room detail amenities
  As a Supplier ISBAT specify room details for an accommodation product

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    And the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And "Awesome Accommodation" has the following products:
      | name         | _type                |
      | Test product | AccommodationProduct |
    And I sign in as "admin@test.com/please"

  Scenario: Specifying accommodation amenities
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And I select "Babysitting" from "accommodation_product_room_detail_amenities"
    And I select "Barbecue" from "accommodation_product_room_detail_amenities"
    And I select "Children's Play Area" from "accommodation_product_room_detail_amenities"
    And I select "Dry Cleaning" from "accommodation_product_room_detail_amenities"
    And I select "Wi-Fi Internet" from "accommodation_product_room_detail_amenities"
    And I select "Swimming Pool" from "accommodation_product_room_detail_amenities"
    And I select "24 Hour Security" from "accommodation_product_room_detail_amenities"
    And  I press "Save & Next"
    Then "Test product" accommodation product room detail amenities should have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Dry Cleaning         |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And I unselect "Dry Cleaning" from "accommodation_product_room_detail_amenities"
    And I press "Save & Next"
    Then "Test product" accommodation product room detail amenities should have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |
    Then "Test product" accommodation product room detail amenities should not have the following values:
      | name         |
      | Dry Cleaning |
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And I unselect "Babysitting" from "accommodation_product_room_detail_amenities"
    And I unselect "Barbecue" from "accommodation_product_room_detail_amenities"
    And I unselect "Children's Play Area" from "accommodation_product_room_detail_amenities"
    And I unselect "Dry Cleaning" from "accommodation_product_room_detail_amenities"
    And I unselect "Wi-Fi Internet" from "accommodation_product_room_detail_amenities"
    And I unselect "Swimming Pool" from "accommodation_product_room_detail_amenities"
    And I unselect "24 Hour Security" from "accommodation_product_room_detail_amenities"
    And I press "Save & Next"
    Then "Test product" accommodation product room detail amenities should not have the following values:
      | name                 |
      | Babysitting          |
      | Barbecue             |
      | Children's Play Area |
      | Dry Cleaning         |
      | Wi-Fi Internet       |
      | Swimming Pool        |
      | 24 Hour Security     |
