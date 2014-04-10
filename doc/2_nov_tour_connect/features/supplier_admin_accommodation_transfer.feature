Feature: Supplier Admin manage accommodation transfer
  As a Supplier Admin ISBAT manage accommodation transfer

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
  Scenario: Specifying accommodation transfer information
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And  I am on the "transfer" step of the edit admin "Awesome Accommodation" accommodation page
    When I check "Provided by Hotel"
    And  I check "Include Baby Seats"
    And  I fill in the following:
      | From Location        | Phoenix International Airport |
      | To Location          | Airport Hilton                |
      | Maximum Passengers   | 8                             |
      | Luggage Restrictions | Carry-on only.                |
      | Pick Up Details      | South-side curb.              |
    And I fill in "accommodation_transfer_attributes_adult_return_net_rate" with "1"
    And I select "flat fee" from "accommodation_transfer_attributes_adult_return_commission_type"
    And I fill in "accommodation_transfer_attributes_adult_return_commission_amount" with "1"
    And I fill in "accommodation_transfer_attributes_child_return_net_rate" with "2"
    And I select "flat fee" from "accommodation_transfer_attributes_child_return_commission_type"
    And I fill in "accommodation_transfer_attributes_child_return_commission_amount" with "2"
    And I fill in "accommodation_transfer_attributes_adult_one_way_net_rate" with "3"
    And I select "flat fee" from "accommodation_transfer_attributes_adult_one_way_commission_type"
    And I fill in "accommodation_transfer_attributes_adult_one_way_commission_amount" with "3"
    And I fill in "accommodation_transfer_attributes_child_one_way_net_rate" with "4"
    And I select "flat fee" from "accommodation_transfer_attributes_child_one_way_commission_type"
    And I fill in "accommodation_transfer_attributes_child_one_way_commission_amount" with "4"
    And  I press "Save & Next"
    Then "Awesome Accommodation" transfer should have the following values:
      | adult_one_way_commission_amount | 3                             |
      | adult_one_way_commission_type   | flat fee                      |
      | adult_one_way_net_rate          | 3                             |
      | adult_return_commission_amount  | 1                             |
      | adult_return_commission_type    | flat fee                      |
      | adult_return_net_rate           | 1                             |
      | child_one_way_commission_amount | 4                             |
      | child_one_way_commission_type   | flat fee                      |
      | child_one_way_net_rate          | 4                             |
      | child_return_commission_amount  | 2                             |
      | child_return_commission_type    | flat fee                      |
      | child_return_net_rate           | 2                             |
      | from_location                   | Phoenix International Airport |
      | include_baby_seats              | true                          |
      | luggage_restrictions            | Carry-on only.                |
      | max_passengers                  | 8                             |
      | pick_up_details                 | South-side curb.              |
      | provided_by_hotel               | true                          |
      | to_location                     | Airport Hilton                |
