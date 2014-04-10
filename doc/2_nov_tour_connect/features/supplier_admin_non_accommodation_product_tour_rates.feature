Feature: Supplier admin non accommodation product tour rates
  As a Supplier ISBAT specify pricing for each product

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    And the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following products:
      | name         | _type                   |
      | Test product | NonAccommodationProduct |
    And "Awesome Non Accommodation" has the following seasons:
      | name   | begins_on  | ends_on    |
      | summer | 2011-05-01 | 2011-08-01 |
      | fall   | 2011-08-02 | 2011-09-30 |
      | winter | 2011-10-01 | 2012-02-01 |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  @javascript
  Scenario: Specifying non accommodation product tour rates with week days
    Given I am on the "tour_rates" step of the edit admin non accommodation "Test product" product page

    When I follow "Add season rate group"
    And  I select "summer" from "Season Name:" within "#rate-groups > .fields:nth-child(1)"
    And  I wait for the AJAX call to finish
    And  I check the following fields within "#rate-groups > .fields:nth-child(1)":
      | All           | true |
      | Inbound       | true |
      | Domestic      | true |
      | ETA           | true |
      | other-markets | true |
    And I fill in "Other:" with "SuperMarket" within "#rate-groups > .fields:nth-child(1)"
    When I choose "Week Days" within "#rate-groups > .fields:nth-child(1)"
    Then "#departure-date-range" should not be visible
    And I check the following fields within "#rate-groups > .fields:nth-child(1)":
      | Sun  | true |
      | Mon  | true |
      | Tues | true |
      | Wed  | true |
      | Thur | true |
      | Fri  | true |
      | Sat  | true |
    And I check "Include Meal" within "#rate-groups > .fields:nth-child(1)"
    And I fill in "Meal details" with "Cake" within "#rate-groups > .fields:nth-child(1)"
    And I check "GST Tax included" within "#rate-groups > .fields:nth-child(1)"

    And   I follow "Add season rate group"
    And   I select "winter" from "Season Name:" within "#rate-groups > .fields:nth-child(2)"
    And   I wait for the AJAX call to finish
    And   I check the following fields within "#rate-groups > .fields:nth-child(2)":
      | All           | true |
      | Inbound       | true |
      | Domestic      | true |
      | ETA           | true |
      | other-markets | true |
    And  I fill in "Other:" with "SuperMarket2" within "#rate-groups > .fields:nth-child(2)"
    When I choose "Date Range" within "#rate-groups > .fields:nth-child(2)"
    Then "#departure-week-days" should not be visible
    When I follow "Add date range"
    And  I select "2011-10-01" as the "From" date within "#departure-date-range > .fields:nth-child(1)"
    And  I select "2011-10-02" as the "To" date within "#departure-date-range > .fields:nth-child(1)"
    And  I check "Include Meal" within "#rate-groups > .fields:nth-child(2)"
    And  I fill in "Meal details" with "Cake2" within "#rate-groups > .fields:nth-child(2)"
    And  I check "GST Tax included" within "#rate-groups > .fields:nth-child(2)"

    And I follow "Add season rate group"
    And I select "fall" from "Season Name:" within "#rate-groups > .fields:nth-child(3)"
    And I wait for the AJAX call to finish
    And I follow "Remove season rate group" within "#rate-groups > .fields:nth-child(3)"

    When I press "Save & Next"
    Then I should see "Step Three: Tour Bonus"

    And  "Test product" product rates should have the following values:
      | season_name | all_markets | inbound_markets | domestic_markets | eta_markets | other_markets | other_markets_value | departs    | departure_week_days                                                                                  | include_meal | meal_details | gst_tax_included |
      | summer      | true        | true            | true             | true        | true          | SuperMarket         | week_days  | {"sun"=>true, "mon"=>true, "tues"=>true, "wed"=>true, "thur"=>true, "fri"=>true, "sat"=>true}        | true         | Cake         | true             |
      | winter      | true        | true            | true             | true        | true          | SuperMarket2        | date_range | {"sun"=>false, "mon"=>false, "tues"=>false, "wed"=>false, "thur"=>false, "fri"=>false, "sat"=>false} | true         | Cake2        | true             |
    And  "Test product" product rates should not have the following values:
      | season_name |
      | fall        |

  @javascript
  Scenario: Specifying non accommodation product tour blackout dates
    Given the "Awesome Non Accommodation" property "summer" season has the following blackout periods:
      | name            | begins_on  | ends_on    |
      | A Holiday       | 2011-07-24 | 2011-07-26 |
      | Another Holiday | 2011-06-20 | 2011-06-20 |
    And I am on the "tour_rates" step of the edit admin non accommodation "Test product" product page
    When I follow "Add season rate group"
    And  I select "summer" from "Season Name:"
    And  I wait for the AJAX call to finish
    Then I should see "A Holiday"
    And  I should see "Another Holiday"

    When I follow "Add another blackout (to this product only)"
    And  I fill in "Name" with "Blackout 1" within "#blackouts > .fields:nth-child(1)"
    And  I select "2011-06-01" as the "From" date within "#blackouts > .fields:nth-child(1)"
    And  I select "2011-06-02" as the "To" date within "#blackouts > .fields:nth-child(1)"

    When I follow "Add another blackout (to this product only)"
    And  I fill in "Name" with "Blackout 2" within "#blackouts > .fields:nth-child(2)"
    And  I select "2011-07-01" as the "From" date within "#blackouts > .fields:nth-child(2)"
    And  I select "2011-07-02" as the "To" date within "#blackouts > .fields:nth-child(2)"

    When I follow "Add another blackout (to this product only)"
    And  I fill in "Name" with "Blackout 3" within "#blackouts > .fields:nth-child(3)"
    And  I select "2011-08-01" as the "From" date within "#blackouts > .fields:nth-child(3)"
    And  I select "2011-08-01" as the "To" date within "#blackouts > .fields:nth-child(3)"
    When I follow "Remove this blackout" within "#blackouts > .fields:nth-child(3)"

    When I press "Save & Next"
    Then I should see "Step Three: Tour Bonus"

    And the "Test product" product rate group "summer" should have the following blackout periods:
      | name       | begins_on  | ends_on    |
      | Blackout 1 | 2011-06-01 | 2011-06-02 |
      | Blackout 2 | 2011-07-01 | 2011-07-02 |
    And the "Test product" product rate group "summer" should not have the following blackout periods:
      | name       |
      | Blackout 3 |

  @javascript
  Scenario: Specifying non accommodation product tour rate date ranges
    Given I am on the "tour_rates" step of the edit admin non accommodation "Test product" product page
    And   I follow "Add season rate group"
    And   I select "summer" from "Season Name:"
    And   I wait for the AJAX call to finish
    When I choose "Date Range"
    Then "#departure-week-days" should not be visible
    When I follow "Add date range"
    And  I select "2011-10-01" as the "From" date within "#departure-date-range > .fields:nth-child(1)"
    And  I select "2011-10-02" as the "To" date within "#departure-date-range > .fields:nth-child(1)"

    When I follow "Add date range"
    And  I select "2011-11-01" as the "From" date within "#departure-date-range > .fields:nth-child(2)"
    And  I select "2011-11-02" as the "To" date within "#departure-date-range > .fields:nth-child(2)"

    When I follow "Add date range"
    And  I select "2011-12-01" as the "From" date within "#departure-date-range > .fields:nth-child(3)"
    And  I select "2011-12-02" as the "To" date within "#departure-date-range > .fields:nth-child(3)"
    When I follow "Remove date range" within "#departure-date-range > .fields:nth-child(3)"

    When I press "Save & Next"
    Then I should see "Step Three: Tour Bonus"
    And the "Test product" product rate group "summer" date ranges should have the following values:
      | from       | to         |
      | 2011-10-01 | 2011-10-02 |
      | 2011-11-01 | 2011-11-02 |
    And the "Test product" product rate group "summer" date ranges should not have the following values:
      | from       | to         |
      | 2011-12-01 | 2011-12-02 |

  @javascript
  Scenario: Specifying non accommodation product tour rate options
    Given I am on the "tour_rates" step of the edit admin non accommodation "Test product" product page
    And   I follow "Add season rate group"
    And   I select "summer" from "Season Name:"
    And   I wait for the AJAX call to finish

    When I follow "Add rate option"
    And  I fill in "Description" with "Description 1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Price code" with "Price Code 1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Adult rate" with "1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Child rate" with "1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Infant rate" with "1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Student rate" with "1" within ".product-rates > .fields:nth-child(1)"
    And  I fill in "Concession rate" with "1" within ".product-rates > .fields:nth-child(1)"

    When I follow "Add rate option"
    And  I fill in "Description" with "Description 2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Price code" with "Price Code 2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Adult rate" with "2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Child rate" with "2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Infant rate" with "2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Student rate" with "2" within ".product-rates > .fields:nth-child(2)"
    And  I fill in "Concession rate" with "2" within ".product-rates > .fields:nth-child(2)"

    When I follow "Add rate option"
    And  I fill in "Description" with "Description 3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Price code" with "Price Code 3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Adult rate" with "3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Child rate" with "3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Infant rate" with "3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Student rate" with "3" within ".product-rates > .fields:nth-child(3)"
    And  I fill in "Concession rate" with "3" within ".product-rates > .fields:nth-child(3)"
    When I follow "Remove rate option" within ".product-rates > .fields:nth-child(3)"

    When I press "Save & Next"
    Then I should see "Step Three: Tour Bonus"

    And the "Test product" product rate group "summer" product rates should have the following values:
      | description   | price_code   | adult_rate | child_rate | infant_rate | student_rate | concession_rate |
      | Description 1 | Price Code 1 | 1          | 1          | 1           | 1            | 1               |
      | Description 2 | Price Code 2 | 2          | 2          | 2           | 2            | 2               |
    And the "Test product" product rate group "summer" product rates should not have the following values:
      | description   | price_code   | adult_rate | child_rate | infant_rate | student_rate | concession_rate |
      | Description 3 | Price Code 3 | 3          | 3          | 3           | 3            | 3               |

  @javascript
  Scenario: non accommodation product tour rate special pricing period
    Given the "Awesome Non Accommodation" property "summer" season has the following special pricing periods:
      | name                    | begins_on  | ends_on    |
      | Holiday Pricing         | 2011-07-24 | 2011-07-26 |
      | Another Holiday Pricing | 2011-06-20 | 2011-06-20 |
    And I am on the "tour_rates" step of the edit admin non accommodation "Test product" product page
    When I follow "Add season rate group"
    And  I select "summer" from "Season Name:"
    And  I wait for the AJAX call to finish
    Then I should see "Holiday Pricing"
    And  I should see "Another Holiday Pricing"

    When I follow "Add special pricing period"
    And  I fill in "Name" with "Spp Test 1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I select "2011-05-02" as the "From" date within ".special-pricing-periods > .fields:nth-child(3)"
    And  I select "2011-05-04" as the "To" date within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Price code" with "Spp Price Code 1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Adult rate" with "1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Child rate" with "1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Infant rate" with "1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Student rate" with "1" within ".special-pricing-periods > .fields:nth-child(3)"
    And  I fill in "Concession rate" with "1" within ".special-pricing-periods > .fields:nth-child(3)"

    When I follow "Add special pricing period"
    And  I fill in "Name" with "Spp Test 2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I select "2011-05-05" as the "From" date within ".special-pricing-periods > .fields:nth-child(4)"
    And  I select "2011-05-07" as the "To" date within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Price code" with "Spp Price Code 2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Adult rate" with "2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Child rate" with "2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Infant rate" with "2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Student rate" with "2" within ".special-pricing-periods > .fields:nth-child(4)"
    And  I fill in "Concession rate" with "2" within ".special-pricing-periods > .fields:nth-child(4)"

    When I follow "Add special pricing period"
    And  I fill in "Name" with "Spp Test 3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I select "2011-05-08" as the "From" date within ".special-pricing-periods > .fields:nth-child(5)"
    And  I select "2011-05-09" as the "To" date within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Price code" with "Spp Price Code 3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Adult rate" with "3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Child rate" with "3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Infant rate" with "3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Student rate" with "3" within ".special-pricing-periods > .fields:nth-child(5)"
    And  I fill in "Concession rate" with "3" within ".special-pricing-periods > .fields:nth-child(5)"
    When I follow "Remove special pricing" within ".special-pricing-periods > .fields:nth-child(5)"
    When I press "Save & Next"
    Then I should see "Step Three: Tour Bonus"

    And the "Test product" product rate group "summer" special pricing periods should have the following values:
      | name       | price_code       | adult_rate | child_rate | infant_rate | student_rate | concession_rate |
      | Spp Test 1 | Spp Price Code 1 | 1.0        | 1.0        | 1.0         | 1.0          | 1.0             |
      | Spp Test 2 | Spp Price Code 2 | 2.0        | 2.0        | 2.0         | 2.0          | 2.0             |
    And the "Test product" product rate group "summer" special pricing periods should not have the following values:
      | name       |
      | Spp Test 3 |
