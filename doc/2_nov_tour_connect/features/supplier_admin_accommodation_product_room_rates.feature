Feature: Supplier admin accommodation product room rates
  As a Supplier ISBAT specify room rates for an accommodation product

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
    And "Awesome Accommodation" has the following seasons:
      | name   | begins_on  | ends_on    |
      | summer | 2011-05-01 | 2011-08-01 |
      | fall   | 2011-08-02 | 2011-09-30 |
      | winter | 2011-10-01 | 2012-02-01 |
    And I sign in as "admin@test.com/please"

  @javascript
  Scenario: Specifying accommodation product room rates (basic information)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"
    And  I check the following fields within "#room-rates > .fields:nth-child(1)":
      | All           | true |
      | Inbound       | true |
      | Domestic      | true |
      | ETA           | true |
      | other-markets | true |
    And I fill in "Other:" with "SuperMarket" within "#room-rates > .fields:nth-child(1)"
    And I choose "Per person per night" within "#room-rates > .fields:nth-child(1)"
    And I fill in "Please detail inclusions and/or bonus offers here:" with "Inclusions and bonus offers" within "#room-rates > .fields:nth-child(1)"

    And I follow "Add a season"
    And I select "winter" from "Season Name:" within "#room-rates > .fields:nth-child(2)"
    And I check the following fields within "#room-rates > .fields:nth-child(2)":
      | All           | false |
      | Inbound       | false |
      | Domestic      | false |
      | ETA           | false |
      | other-markets | false |
    And I choose "Per room per night" within "#room-rates > .fields:nth-child(2)"
    And I fill in "Please detail inclusions and/or bonus offers here:" with "None" within "#room-rates > .fields:nth-child(2)"

    And I follow "Add a season"
    And I select "fall" from "Season Name:" within "#room-rates > .fields:nth-child(3)"
    And I follow "Remove season" within "#room-rates > .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rates should have the following values:
      | season_name | all_markets | inbound_markets | domestic_markets | eta_markets | other_markets | other_markets_value | rate_type  | inclusion                   |
      | summer      | true        | true            | true             | true        | true          | SuperMarket         | per person | Inclusions and bonus offers |
      | winter      | false       | false           | false            | false       | false         |                     | per room   | None                        |
    And "Test product" room rates should not have the following values:
      | season_name |
      | fall        |

  @javascript
  Scenario: Specifying accommodation product room rates (validity dates)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page
    And   it is the year 2011

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And I select "2011-07-01" as the "From" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(1)"
    And I select "2011-07-31" as the "To" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(1)"

    And I follow "Add a date"
    And I select "2011-05-15" as the "From" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(2)"
    And I select "2011-05-16" as the "To" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(2)"

    And I follow "Add a date"
    And I select "2011-06-01" as the "From" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(3)"
    And I select "2011-06-03" as the "To" date within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(3)"
    And I follow "Remove this date" within "#room-rates > .fields:nth-child(1) .validity-dates .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rate "summer" validity dates should have the following values:
      | from       | to         |
      | 2011-07-01 | 2011-07-31 |
      | 2011-05-15 | 2011-05-16 |
    And "Test product" room rate "summer" validity dates should not have the following values:
      | from       | to         |
      | 2011-06-01 | 2011-06-03 |


  @javascript
  Scenario: Specifying accommodation product room rates (product rates)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And  I fill in "Description" with "Description 1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Price code" with "Price Code 1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Minimum nights" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Adult rate" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Child rate" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Infant rate" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Student rate" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"
    And  I fill in "Per night rate" with "1" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(1)"

    When I follow "Add rate option"
    And  I fill in "Description" with "Description 2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Price code" with "Price Code 2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Minimum nights" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Adult rate" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Child rate" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Infant rate" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Student rate" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"
    And  I fill in "Per night rate" with "2" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(2)"

    When I follow "Add rate option"
    And  I fill in "Description" with "Description 3" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(3)"
    When I follow "Remove rate option" within "#room-rates > .fields:nth-child(1) .product-rates .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rate "summer" product rates should have the following values:
      | description   | price_code   | minimum_nights | adult_rate | child_rate | infant_rate | student_rate | per_night_rate |
      | Description 1 | Price Code 1 | 1              | 1          | 1          | 1           | 1            | 1              |
      | Description 2 | Price Code 2 | 2              | 2          | 2          | 2           | 2            | 2              |
    And "Test product" room rate "summer" product rates should not have the following values:
      | description   |
      | Description 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (weekend rates)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"
    And  I uncheck "Same as other days"
    And  I fill in "Weekend days" with "Sat and Sun"
    And  I fill in "Minimum stays" with "2"

    And  I fill in "Description" with "Description 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Price code" with "Price Code 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Minimum nights" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Adult rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Child rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Infant rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Student rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Per night rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"

    When I follow "Add rate option" within "#room-rates > .fields:nth-child(1) .weekend-rates"
    And  I fill in "Description" with "Description 2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Price code" with "Price Code 2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Minimum nights" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Adult rate" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Child rate" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Infant rate" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Student rate" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"
    And  I fill in "Per night rate" with "2" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(2)"

    When I follow "Add rate option" within "#room-rates > .fields:nth-child(1) .weekend-rates"
    And  I fill in "Description" with "Description 3" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(3)"
    When I follow "Remove rate option" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rates should have the following values:
      | season_name | weekend_same_as_other_days | weekend_days | weekend_minimum_nights |
      | summer      | false                      | Sat and Sun  | 2                      |
    Then "Test product" room rate "summer" weekend rates should have the following values:
      | description   | price_code   | minimum_nights | adult_rate | child_rate | infant_rate | student_rate | per_night_rate |
      | Description 1 | Price Code 1 | 1              | 1          | 1          | 1           | 1            | 1              |
      | Description 2 | Price Code 2 | 2              | 2          | 2          | 2           | 2            | 2              |
    And "Test product" room rate "summer" weekend rates should not have the following values:
      | description   |
      | Description 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (weekend rates same as other days)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"
    And  I fill in "Weekend days" with "Sat and Sun"
    And  I fill in "Minimum stays" with "2"

    And  I fill in "Description" with "Description 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Price code" with "Price Code 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Minimum nights" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Adult rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Child rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Infant rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Student rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Per night rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"

    And I check "Same as other days"
    And I press "Save & Next"
    Then "Test product" room rates should have the following values:
      | season_name | weekend_same_as_other_days | weekend_days | weekend_minimum_nights |
      | summer      | true                       |              |                        |
    And "Test product" room rate "summer" weekend rates should not have the following values:
      | description   |
      | Description 1 |

  @javascript
  Scenario: Specifying accommodation product room rates (weekend rates same as other days [already persisted])
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"
    And  I fill in "Weekend days" with "Sat and Sun"
    And  I fill in "Minimum stays" with "2"

    And  I fill in "Description" with "Description 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Price code" with "Price Code 1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Minimum nights" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Adult rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Child rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Infant rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Student rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"
    And  I fill in "Per night rate" with "1" within "#room-rates > .fields:nth-child(1) .weekend-rates .fields:nth-child(1)"

    And I press "Save & Next"
    Then "Test product" room rates should have the following values:
      | season_name | weekend_same_as_other_days | weekend_days | weekend_minimum_nights |
      | summer      | false                      | Sat and Sun  | 2                      |
    And "Test product" room rate "summer" weekend rates should have the following values:
      | description   | price_code   | minimum_nights | adult_rate | child_rate | infant_rate | student_rate | per_night_rate |
      | Description 1 | Price Code 1 | 1              | 1          | 1          | 1           | 1            | 1              |

    When I go to the "room_rates" step of the edit admin accommodation "Test product" product page
    And I check "Same as other days" within "#room-rates > .fields:nth-child(1)"
    And I press "Save & Next"
    Then "Test product" room rates should have the following values:
      | season_name | weekend_same_as_other_days | weekend_days | weekend_minimum_nights |
      | summer      | true                       |              |                        |
    And "Test product" room rate "summer" weekend rates should not have the following values:
      | description   |
      | Description 1 |

  @javascript
  Scenario: Specifying accommodation product room rates (stay pay offers)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And I check "Available" within "#room-rates > .fields:nth-child(1)"
    And I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And I fill in "Name" with "Sp 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Stay" with "1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Pay" with "11" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Comment" with "sp comment 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Stay" with "2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Pay" with "22" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Comment" with "sp comment 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Stay" with "3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Pay" with "33" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Comment" with "sp comment 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    When I follow "Remove offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rate "summer" stay pay offers should have the following values:
      | name | stay | pay | comment      |
      | Sp 1 | 1    | 11  | sp comment 1 |
      | Sp 2 | 2    | 22  | sp comment 2 |
    And "Test product" room rate "summer" stay pay offers should not have the following values:
      | name | comment      |
      | Sp 3 | sp comment 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (stay pay offers unavailable)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And I check "Available" within "#room-rates > .fields:nth-child(1)"
    And I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And I fill in "Name" with "Sp 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Stay" with "1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Pay" with "11" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Comment" with "sp comment 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Stay" with "2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Pay" with "22" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Comment" with "sp comment 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Stay" with "3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Pay" with "33" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Comment" with "sp comment 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    When I follow "Remove offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"

    And I uncheck "Available" within "#room-rates > .fields:nth-child(1)"
    And I press "Save & Next"
    And "Test product" room rate "summer" stay pay offers should not have the following values:
      | name |
      | Sp 1 |
      | Sp 2 |
      | Sp 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (stay pay offers unavailable [already persisted])
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And I check "Available" within "#room-rates > .fields:nth-child(1)"
    And I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And I fill in "Name" with "Sp 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Stay" with "1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Pay" with "11" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"
    And I fill in "Comment" with "sp comment 1" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(1)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Stay" with "2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Pay" with "22" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"
    And  I fill in "Comment" with "sp comment 2" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(2)"

    When I follow "Add offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers"
    And  I fill in "Name" with "Sp 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Stay" with "3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Pay" with "33" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    And  I fill in "Comment" with "sp comment 3" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"
    When I follow "Remove offer" within "#room-rates > .fields:nth-child(1) .stay-pay-offers .fields:nth-child(3)"

    And I press "Save & Next"
    Then "Test product" room rate "summer" stay pay offers should have the following values:
      | name | stay | pay | comment      |
      | Sp 1 | 1    | 11  | sp comment 1 |
      | Sp 2 | 2    | 22  | sp comment 2 |
    And "Test product" room rate "summer" stay pay offers should not have the following values:
      | name | comment      |
      | Sp 3 | sp comment 3 |

    When I go to the "room_rates" step of the edit admin accommodation "Test product" product page
    And I uncheck "Available" within "#room-rates > .fields:nth-child(1)"
    And I press "Save & Next"
    And "Test product" room rate "summer" stay pay offers should not have the following values:
      | name |
      | Sp 1 |
      | Sp 2 |
      | Sp 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (meal rates)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page
    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And  I fill in "Name" with "mr 1" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(1)"
    And  I fill in "AD Rate" with "1" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(1)"
    And  I fill in "CH Rate" with "11" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(1)"
    And  I fill in "Description" with "mr description 1" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(1)"

    When I follow "Add a meal rate" within "#room-rates > .fields:nth-child(1) .meal-rates"
    And  I fill in "Name" with "mr 2" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(2)"
    And  I fill in "AD Rate" with "2" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(2)"
    And  I fill in "CH Rate" with "22" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(2)"
    And  I fill in "Description" with "mr description 2" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(2)"

    When I follow "Add a meal rate" within "#room-rates > .fields:nth-child(1) .meal-rates"
    And  I fill in "Name" with "mr 3" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(3)"
    And  I fill in "AD Rate" with "3" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(3)"
    And  I fill in "CH Rate" with "33" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(3)"
    And  I fill in "Description" with "mr description 3" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(3)"
    When I follow "Remove meal rate" within "#room-rates > .fields:nth-child(1) .meal-rates .fields:nth-child(3)"

    And I press "Save & Next"

    Then "Test product" room rate "summer" meal rates should have the following values:
      | name | ad_rate | ch_rate | description      |
      | mr 1 | 1       | 11      | mr description 1 |
      | mr 2 | 2       | 22      | mr description 2 |
    And "Test product" room rate "summer" meal rates should not have the following values:
      | name | comment | ch_rate | description      |
      | mr 3 | 3       | 33      | mr description 3 |

  @javascript
  Scenario: Specifying accommodation product room rates (special event meals)
    Given I am on the "room_rates" step of the edit admin accommodation "Test product" product page

    When I follow "Add a season"
    And  I select "summer" from "Season Name:" within "#room-rates > .fields:nth-child(1)"

    And  I fill in "Event name" with "se meal 1" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"
    And  I fill in "Date" with "2011-01-01" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"
    And  I fill in "AD Rate" with "1" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"
    And  I fill in "CH Rate" with "11" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"
    And  I fill in "Description" with "se meal description 1" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"
    And  I check "Mandatory" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(1)"


    When I follow "Add special event meal rate" within "#room-rates > .fields:nth-child(1) .special-event-meals"
    And  I fill in "Event name" with "se meal 2" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"
    And  I fill in "Date" with "2011-01-02" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"
    And  I fill in "AD Rate" with "2" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"
    And  I fill in "CH Rate" with "22" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"
    And  I fill in "Description" with "se meal description 2" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"
    And  I check "Mandatory" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(2)"

    When I follow "Add special event meal rate" within "#room-rates > .fields:nth-child(1) .special-event-meals"
    And  I fill in "Event name" with "se meal 3" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    And  I fill in "Date" with "2011-01-03" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    And  I fill in "AD Rate" with "3" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    And  I fill in "CH Rate" with "33" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    And  I fill in "Description" with "se meal description 3" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    And  I check "Mandatory" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"
    When I follow "Remove special event meal rate" within "#room-rates > .fields:nth-child(1) .special-event-meals .fields:nth-child(3)"

    And I press "Save & Next"

    Then "Test product" room rate "summer" special event meals should have the following values:
      | name      | ad_rate | ch_rate | description           | mandatory |
      | se meal 1 | 1       | 11      | se meal description 1 | true      |
      | se meal 2 | 2       | 22      | se meal description 2 | true      |
    And "Test product" room rate "summer" special event meals should not have the following values:
      | name      | comment | ch_rate | description           | mandatory |
      | se meal 3 | 3       | 33      | se meal description 3 | true      |
