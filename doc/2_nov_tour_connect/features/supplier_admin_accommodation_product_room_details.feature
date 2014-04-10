Feature: Supplier admin accommodation product room details
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

  @javascript
  Scenario: Specifying accommodation product room details with late checkout
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And  I select "8:00" as the "Check In:" time
    And  I select "9:00" as the "Check Out:" time
    And  I check "Available"
    And  I select "11:00" as the "Until:" time
    And  I select "Free" from "Cost:"
    And  I choose "Room"
    And  I select "2" from "Adults"
    And  I fill in the following:
      | Adult/Child      | 2AD/1CH |
      | Existing bedding | S       |
    And  I select "2" from "Sofa"
    And  I select "1" from "Rollaways"
    And  I check "Considered as Existing bedding for children"
    And  I choose "Not Available"
    And  I press "Save & Next"
    Then I should see "Step Three: Room Rates"
    And  "Test product" room detail should have the following values:
      | check_in_at | check_out_at | late_check_out | late_check_out_at | late_check_out_cost | room_classification | maximum_pax_adults | maximum_pax_adult_child | existing_bedding | sofas | rollaways | consider_as_existing_bedding | interconnecting_rooms |
      | 8:00        | 9:00         | true           | 11:00             | free                | room                | 2                  | 2AD/1CH                 | S                | 2     | 1         | true                         | Not Available         |

  @javascript
  Scenario: Specifying accommodation product room details without late checkout
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And  I check "Available"
    And  I select "9:00" as the "Until:" time
    And  I uncheck "Available"
    And  I press "Save & Next"
    Then I should see "Step Three: Room Rates"
    And  "Test product" room detail should have the following values:
      | late_check_out | late_check_out_at | late_check_out_cost |
      | false          |                   |                     |

  @javascript
  Scenario: Specifying photos
    When I go to "room_details" step of the edit admin accommodation "Test product" product page
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.png" to "Select from your computer" within ".images .fields:nth-child(1)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.jpg" to "Select from your computer" within ".images .fields:nth-child(2)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.gif" to "Select from your computer" within ".images .fields:nth-child(3)"
    And  I follow "Remove this image" within ".images .fields:nth-child(3)"
    And  I press "Save & Next"
    Then "Test product" product images should have the following values:
      | attachment_name |
      | logo.png        |
      | logo.jpg        |
    And "Test product" product images should not have the following values:
      | attachment_name |
      | logo.gif        |
