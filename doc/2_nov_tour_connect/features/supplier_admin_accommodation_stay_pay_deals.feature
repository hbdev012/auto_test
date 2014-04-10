Feature: Supplier Admin manage accommodation stay pay deals
  As a Supplier Admin ISBAT manage accommodation stay pay deals

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
  Scenario: Specifying accommodation stay/pay special offers
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And  I am on the "special_offers" step of the edit admin "Awesome Accommodation" accommodation page
    And I follow "Add stay/pay deal"
    And I select "2011-10-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And I select "2012-10-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(1)"
    And I select "2011-09-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And I select "2012-09-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(1)"
    And I select "2011-08-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And I select "2012-08-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#stay-pay-deals > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    When I fill in "Name" with "test" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Stay" with "3" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Pay" with "4" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(1)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(1)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(1)"
    When I fill in "Name" with "test two" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Stay" with "5" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Pay" with "6" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(2)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(2)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(1)"
    When I fill in "Name" with "test three" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Stay" with "7" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Pay" with "8" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(3)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(3)"
    And  I follow "Remove offer" within "#stay-pay-deals > .fields:nth-child(1) #stay-pay-offer .fields:nth-child(3)"
    And I check "Partial offers allowed" within "#stay-pay-deals > .fields:nth-child(1)"
    And I fill in "Booking code" with "BC12345" within "#stay-pay-deals > .fields:nth-child(1)"
    And I check "Combinable with other offers allowed" within "#stay-pay-deals > .fields:nth-child(1)"
    And I fill in "Offers allowed to be combined with" with "all of them" within "#stay-pay-deals > .fields:nth-child(1)"
    And I fill in "Special conditions" with "these are special" within "#stay-pay-deals > .fields:nth-child(1)"
    And I check "Standard room meal offer apply" within "#stay-pay-deals > .fields:nth-child(1)"

    And I follow "Add stay/pay deal"

    And I select "2006-10-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And I select "2007-10-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(2)"
    And I select "2006-09-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And I select "2007-09-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(2)"
    And I select "2006-08-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And I select "2007-08-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#stay-pay-deals > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    When I fill in "Name" with "1test" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Stay" with "13" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Pay" with "14" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(1)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(1)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(2)"
    When I fill in "Name" with "1test two" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Stay" with "15" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Pay" with "16" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(2)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(2)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(2)"
    When I fill in "Name" with "1test three" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Stay" with "17" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Pay" with "18" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(3)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(3)"
    And  I follow "Remove offer" within "#stay-pay-deals > .fields:nth-child(2) #stay-pay-offer .fields:nth-child(3)"
    And I check "Partial offers allowed" within "#stay-pay-deals > .fields:nth-child(2)"
    And I fill in "Booking code" with "1BC12345" within "#stay-pay-deals > .fields:nth-child(2)"
    And I check "Combinable with other offers allowed" within "#stay-pay-deals > .fields:nth-child(2)"
    And I fill in "Offers allowed to be combined with" with "1all of them" within "#stay-pay-deals > .fields:nth-child(2)"
    And I fill in "Special conditions" with "1these are special" within "#stay-pay-deals > .fields:nth-child(2)"
    And I check "Standard room meal offer apply" within "#stay-pay-deals > .fields:nth-child(2)"

    And I follow "Add stay/pay deal"

    And I select "2015-10-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And I select "2016-10-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(3)"
    And I select "2015-09-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And I select "2016-09-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#stay-pay-deals > .fields:nth-child(3)"
    And I select "2015-08-01" as the "From" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And I select "2016-08-01" as the "To" date within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#stay-pay-deals > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    When I fill in "Name" with "2test" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Stay" with "23" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(1)"
    And  I fill in "Pay" with "24" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(1)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(1)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(3)"
    When I fill in "Name" with "2test two" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Stay" with "25" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(2)"
    And  I fill in "Pay" with "26" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(2)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(2)"
    And  I follow "Add offer" within "#stay-pay-deals > .fields:nth-child(3)"
    When I fill in "Name" with "2test three" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Stay" with "27" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(3)"
    And  I fill in "Pay" with "28" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(3)"
    And  I check "Apply for weekend" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(3)"
    And  I follow "Remove offer" within "#stay-pay-deals > .fields:nth-child(3) #stay-pay-offer .fields:nth-child(3)"
    And I check "Partial offers allowed" within "#stay-pay-deals > .fields:nth-child(3)"
    And I fill in "Booking code" with "2BC12345" within "#stay-pay-deals > .fields:nth-child(3)"
    And I check "Combinable with other offers allowed" within "#stay-pay-deals > .fields:nth-child(3)"
    And I fill in "Offers allowed to be combined with" with "2all of them" within "#stay-pay-deals > .fields:nth-child(3)"
    And I fill in "Special conditions" with "2these are special" within "#stay-pay-deals > .fields:nth-child(3)"
    And I check "Standard room meal offer apply" within "#stay-pay-deals > .fields:nth-child(3)"
    And I follow "Remove this stay/pay deal" within "#stay-pay-deals > .fields:nth-child(3)"
    When I press "Save & Next"

    Then the "Awesome Accommodation" stay pay deals should have the following values:
      | partial_offers | standard_meal_offer | booking_code | special_conditions | combinable_allowed | combined_offer |
      | true           | true                | BC12345      | these are special  | true               | all of them    |
      | true           | true                | 1BC12345     | 1these are special | true               | 1all of them   |
    Then the "Awesome Accommodation" stay pay deals should not have the following values:
      | booking_code |
      | 2BC12345     |

    And the "Awesome Accommodation" stay pay deal "BC12345" stay pay offers should have the following values:
      | name     | stay | pay | apply_for_weekend |
      | test     | 3    | 4   | true              |
      | test two | 5    | 6   | true              |
    And the "Awesome Accommodation" stay pay deal "BC12345" stay pay offers should not have the following values:
      | name       | stay | pay | apply_for_weekend |
      | test three | 7    | 8   | true              |
    And the "Awesome Accommodation" stay pay deal "BC12345" stay pay offers date ranges should have the following values:
      | from       | to         |
      | 2011-10-01 | 2012-10-01 |
      | 2011-09-01 | 2012-09-01 |
    And the "Awesome Accommodation" stay pay deal "BC12345" stay pay offers date ranges should not have the following values:
      | from       | to         |
      | 2011-08-01 | 2012-08-01 |

    And the "Awesome Accommodation" stay pay deal "1BC12345" stay pay offers should have the following values:
      | name      | stay | pay | apply_for_weekend |
      | 1test     | 13   | 14  | true              |
      | 1test two | 15   | 16  | true              |
    And the "Awesome Accommodation" stay pay deal "1BC12345" stay pay offers should not have the following values:
      | name        | stay | pay | apply_for_weekend |
      | 1test three | 17   | 18  | true              |
    And the "Awesome Accommodation" stay pay deal "1BC12345" stay pay offers date ranges should have the following values:
      | from       | to         |
      | 2006-10-01 | 2007-10-01 |
      | 2006-09-01 | 2007-09-01 |
    And the "Awesome Accommodation" stay pay deal "1BC12345" stay pay offers date ranges should not have the following values:
      | from       | to         |
      | 2006-08-01 | 2007-08-01 |
