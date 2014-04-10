Feature: Supplier admin accommodation product basic information
  As a Supplier ISBAT specify basic information for an accommodation product

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
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
    When I go to the new admin accommodation product page
    Then I should be on the home page
    And  I should see "Access Denied"

  Scenario: Specifying accommodation product basic information
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    When I go to the new admin accommodation product page
    And  I select "Awesome Accommodation" from "accommodation_product_property_id"
    And I choose "accommodation_product_allocation_type_allotment"
    And  I fill in the following:
      | Product name      | Taco Tuesday                                  |
      | Product code      | I&lt3T                                        |
      | Number of rooms   | 2                                             |
      | Releaseback days  | 3                                             |
      | Short description | It's tacos, It's Tuesday. You get the idea.   |
      | More details      | Eating Tacos on Tuesday because they're cheap |
      | General notes     | Beef, Chicken, Tomato                         |
    And  I check "Complies to EU Regulations"
    And  I press "Save & Next"
    # Then I should see "Step Two: Room Details"
    And  "Awesome Accommodation" accommodation products should have the following values:
      | name         | code   | allocation_type | number_of_rooms | releaseback_days | short_description                           | details                                       | general_notes         | complies_to_eu_regulations |
      | Taco Tuesday | I&lt3T | allotment       | 2               | 3                | It's tacos, It's Tuesday. You get the idea. | Eating Tacos on Tuesday because they're cheap | Beef, Chicken, Tomato | true                       |

  @javascript
  Scenario: choosing freesale should disable and clear the 'number of rooms' and 'releaseback days' fields
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    When I go to the new admin accommodation product page
    And  I select "Awesome Accommodation" from "accommodation_product_property_id"
    And  I choose "accommodation_product_allocation_type_allotment"
    And  I fill in the following:
      | Product name     | Waffle Wednesday |
      | Number of rooms  | 4                |
      | Releaseback days | 5                |
    And I choose "accommodation_product_allocation_type_freesale"
    Then "input#accommodation_product_number_of_rooms" should not be visible
    And "input#accommodation_product_releaseback_days" should not be visible
    And I press "Save & Next"
    And "Awesome Accommodation" accommodation products should have the following values:
      | name             | code | allocation_type | number_of_rooms | releaseback_days | short_description | details | general_notes | complies_to_eu_regulations |
      | Waffle Wednesday |      | freesale        |                 |                  |                   |         |               |                            |
