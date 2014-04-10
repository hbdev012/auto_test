Feature: Supplier Admin manage non accommodation product basic information
  As a Supplier Admin ISBAT manage non accommodation product basic information

  Background:
    Given the following companies:
      | name             | _type      | country       |
      | Planet Express   | Supplier   | United States |
    Given the following users:
      | email               | company_name     | role  | confirmed | pending |
      | admin@test.com      | Planet Express   | admin | true      | false   |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  Scenario: Only suppliers have access
    Given the following companies:
      | name             | _type      | country       |
      | Planet Hollywood | Contractor | United States |
    And the following users:
      | email               | company_name     | role  | confirmed | pending |
      | contractor@test.com | Planet Hollywood | admin | true      | false   |
    When I sign out
    And  I sign in as "contractor@test.com/please"
    When I go to the new admin non accommodation product page
    Then I should be on the home page
    And  I should see "Access Denied"

  @javascript
  Scenario: Specifying non accommodation product basic information
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    When I go to the new admin non accommodation product page
    And  I select "Awesome Non Accommodation" from "non_accommodation_product_property_id"
    And  I select "Days" from "non_accommodation_product_duration_units"
    And  I fill in the following:
      | Service / Tour name                         | Grand Canyon Tour                               |
      | Tour code                                   | GCT                                             |
      | non_accommodation_product_duration_value    | 1                                               |
      | Short description                           | Ride a donkey into the canyon.                  |
      | More details                                | Climb onto the donkey. Ride it in. Ride it out. |
      | non_accommodation_product_minimum_pax_adult | 1                                               |
      | non_accommodation_product_minimum_pax_child | 0                                               |
      | non_accommodation_product_minimum_pax_total | 1                                               |
      | non_accommodation_product_maximum_pax_adult | 2                                               |
      | non_accommodation_product_maximum_pax_child | 2                                               |
      | non_accommodation_product_maximum_pax_total | 4                                               |
      | non_accommodation_product_pick_up_location  | Flagstaff                                       |
      | non_accommodation_product_drop_off_location | North Rim                                       |
      | Standard inclusion                          | None.                                           |
      | What to bring                               | Water, hat, knife, camera and your own donkey.  |
    And I select "5:00" as the "Depart time" time within "#pick-up-details"
    And I select "7:00" as the "Depart time" time within "#drop-off-details"
    And  I press "Save & Next"
    Then I should see "Step Two: Tour Rates"
    And  "Awesome Non Accommodation" products should have the following values:
      | name              | code | duration_value | duration_units | short_description              | details                                         | minimum_pax_adult | minimum_pax_child | minimum_pax_total | maximum_pax_adult | maximum_pax_child | maximum_pax_total | pick_up_departs_at | pick_up_location | drop_off_departs_at | drop_off_location | standard_inclusion | what_to_bring                                  |
      | Grand Canyon Tour | GCT  | 1              | Days           | Ride a donkey into the canyon. | Climb onto the donkey. Ride it in. Ride it out. | 1                 | 0                 | 1                 | 2                 | 2                 | 4                 | 05:00              | Flagstaff        | 07:00               | North Rim         | None.              | Water, hat, knife, camera and your own donkey. |

  @javascript
  Scenario: Specifying photos
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    When I go to the new admin non accommodation product page
    And  I fill in "Service / Tour name" with "Grand Canyon Tour"
    And  I select "Awesome Non Accommodation" from "non_accommodation_product_property_id"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.png" to "Select from your computer" within ".images .fields:nth-child(1)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.jpg" to "Select from your computer" within ".images .fields:nth-child(2)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.gif" to "Select from your computer" within ".images .fields:nth-child(3)"
    And  I follow "Remove this image" within ".images .fields:nth-child(3)"
    And  I press "Save & Next"
    Then "Grand Canyon Tour" product images should have the following values:
      | attachment_name |
      | logo.png        |
      | logo.jpg        |
    And "Grand Canyon Tour" product images should not have the following values:
      | attachment_name |
      | logo.gif        |
