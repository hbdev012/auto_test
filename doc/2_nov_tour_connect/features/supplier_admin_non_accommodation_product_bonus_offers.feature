Feature: Supplier Admin manage non-accommodation bonus offers
  As a Supplier Admin ISBAT manage non-accommodation bonus offers

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    And the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following products:
      | name            | _type                   |
      | Awesome Product | NonAccommodationProduct |
    And I sign in as "admin@test.com/please"

  @javascript
  Scenario: displaying the correct fields for bonus offer rate type
    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And   I follow "Add a bonus offer"
    Then  I should not see the "Number" field
    And   I should not see the "Maximum Number" field
    When  I select "Per number of guests" from "Rate Type"
    Then  I should see the "Number" field
    And   I should see the "Maximum Number" field
    When  I select "Per night" from "Rate Type"
    Then  I should not see the "Number" field
    And   I should not see the "Maximum Number" field

  @javascript
  Scenario: displaying the correct fields for bonus offer rate
    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And   I follow "Add a bonus offer"
    Then  I should not see the "Discount type" field
    And   I should not see the "Amount" field
    And   I should not see the "Net" field
    And   I should not see the "Commission" field

    When I select "Discount" from "Rate"
    Then I should see the "Discount type" field
    And  I should see the "Amount" field
    And  I should not see the "Net" field
    And  I should not see the "Commission" field

    When I select "percentage" from "Discount type"
    Then I should see the percent symbol
    And  I should not see the correct currency symbol for "Planet Express"
    When I select "flat fee" from "Discount type"
    Then I should see the correct currency symbol for "Planet Express"
    And  I should not see the percent symbol

    When I select "Rate Amount" from "Rate"
    Then I should see the "Net" field
    And  I should see the "Commission" field
    And  I should not see the "Discount type" field
    And  I should not see the "Amount" field

  @javascript
  Scenario: Specifying non accommodation product bonus offers
    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And   I follow "Add a bonus offer"

    When I fill in "Offer Title" with "Honeymoon Bonus" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "2011-10-01" as the "From" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And  I select "2012-10-01" as the "To" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "2011-09-01" as the "From" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And  I select "2012-09-01" as the "To" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "2011-08-01" as the "From" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And  I select "2012-08-01" as the "To" date within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And  I follow "Remove date range" within "#bonus-offers > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And  I fill in "Booking code" with "BC12345" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Offer Details" with "Book your honeymoon with us today!" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "Per number of guests" from "Rate Type" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Number" with "2" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Maximum Number" with "3" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "Discount" from "Rate" within "#bonus-offers > .fields:nth-child(1)"
    And  I select "flat fee" from "Discount type" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Amount" with "5.99" within "#bonus-offers > .fields:nth-child(1)"
    And  I check "Combinable with other offers allowed" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Offers allowed to be combined with" with "all of them" within "#bonus-offers > .fields:nth-child(1)"
    And  I fill in "Special conditions" with "these are special" within "#bonus-offers > .fields:nth-child(1)"

    And I follow "Add a bonus offer"

    And  I fill in "Offer Title" with "1Honeymoon Bonus" within "#bonus-offers > .fields:nth-child(2)"
    And  I select "2006-10-01" as the "From" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And  I select "2007-10-01" as the "To" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(2)"
    And  I select "2006-09-01" as the "From" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And  I select "2007-09-01" as the "To" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(2)"
    And  I select "2006-08-01" as the "From" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And  I select "2007-08-01" as the "To" date within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And  I follow "Remove date range" within "#bonus-offers > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And  I fill in "Booking code" with "1BC12345" within "#bonus-offers > .fields:nth-child(2)"
    And  I fill in "Offer Details" with "1Book your honeymoon with us today!" within "#bonus-offers > .fields:nth-child(2)"
    And  I select "Per night" from "Rate Type" within "#bonus-offers > .fields:nth-child(2)"
    And  I select "Rate Amount" from "Rate" within "#bonus-offers > .fields:nth-child(2)"
    And  I fill in "Net" with "6.99" within "#bonus-offers > .fields:nth-child(2)"
    And  I fill in "Commission" with "1.25" within "#bonus-offers > .fields:nth-child(2)"
    And  I uncheck "Combinable with other offers allowed" within "#bonus-offers > .fields:nth-child(2)"
    And  I fill in "Special conditions" with "1these are special" within "#bonus-offers > .fields:nth-child(2)"

    And I follow "Add a bonus offer"

    And  I fill in "Offer Title" with "2Honeymoon Bonus" within "#bonus-offers > .fields:nth-child(3)"
    And  I select "2015-10-01" as the "From" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And  I select "2016-10-01" as the "To" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(3)"
    And  I select "2015-09-01" as the "From" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And  I select "2016-09-01" as the "To" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And  I follow "Add date range" within "#bonus-offers > .fields:nth-child(3)"
    And  I select "2015-08-01" as the "From" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And  I select "2016-08-01" as the "To" date within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And  I follow "Remove date range" within "#bonus-offers > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And  I fill in "Booking code" with "2BC12345" within "#bonus-offers > .fields:nth-child(3)"
    And  I fill in "Offer Details" with "2Book your honeymoon with us today!" within "#bonus-offers > .fields:nth-child(3)"
    And  I select "Per night" from "Rate Type" within "#bonus-offers > .fields:nth-child(3)"
    And  I select "Rate Amount" from "Rate" within "#bonus-offers > .fields:nth-child(3)"
    And  I fill in "Net" with "2.99" within "#bonus-offers > .fields:nth-child(3)"
    And  I fill in "Commission" with "2.25" within "#bonus-offers > .fields:nth-child(3)"
    And  I uncheck "Combinable with other offers allowed" within "#bonus-offers > .fields:nth-child(3)"
    And  I fill in "Special conditions" with "2these are special" within "#bonus-offers > .fields:nth-child(3)"

    And I follow "Remove this bonus offer" within "#bonus-offers > .fields:nth-child(3)"

    When I press "Save & Next"

    Then the "Awesome Product" product bonus offers should have the following values:
      | title            | booking_code | details                             | rate_type            | number_of_guests | max_number_of_guests | rate        | discount_type | discount_amount | net_rate | commission_percent | special_conditions | combinable_allowed | combined_offer |
      | Honeymoon Bonus  | BC12345      | Book your honeymoon with us today!  | Per number of guests | 2                | 3                    | Discount    | flat fee      | 5.99            |          |                    | these are special  | true               | all of them    |
      | 1Honeymoon Bonus | 1BC12345     | 1Book your honeymoon with us today! | Per night            |                  |                      | Rate Amount |               |                 | 6.99     | 1.25               | 1these are special | false              |                |
    And the "Awesome Product" product bonus offer "BC12345" date ranges should have the following values:
      | from       | to         |
      | 2011-10-01 | 2012-10-01 |
      | 2011-09-01 | 2012-09-01 |
    And the "Awesome Product" product bonus offer "BC12345" date ranges should not have the following values:
      | from       | to         |
      | 2011-08-01 | 2012-08-01 |
    And the "Awesome Product" product bonus offer "1BC12345" date ranges should have the following values:
      | from       | to         |
      | 2006-10-01 | 2007-10-01 |
      | 2006-09-01 | 2007-09-01 |
    And the "Awesome Product" product bonus offer "1BC12345" date ranges should not have the following values:
      | from       | to         |
      | 2006-08-01 | 2007-08-01 |

  Scenario: selecting property bonus offers
    Given the "Awesome Non Accommodation" property has the following bonus offers:
      | title         |
      | bonus offer 1 |
      | bonus offer 2 |
    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And I check "bonus offer 1"
    And I check "bonus offer 2"
    When I press "Save & Next"
    Then the "Awesome Product" should have the following inherited bonus offers:
      | title         |
      | bonus offer 1 |
      | bonus offer 2 |

    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And I uncheck "bonus offer 2"
    When I press "Save & Next"
    Then the "Awesome Product" should have the following inherited bonus offers:
      | title         |
      | bonus offer 1 |
    Then the "Awesome Product" should not have the following inherited bonus offers:
      | title         |
      | bonus offer 2 |

    Given I am on the "tour_bonus" step of the edit admin non accommodation "Awesome Product" product page
    And I uncheck "bonus offer 1"
    When I press "Save & Next"
    Then the "Awesome Product" should not have the following inherited bonus offers:
      | title         |
      | bonus offer 1 |
      | bonus offer 2 |
