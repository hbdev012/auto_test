Feature: Supplier Admin manage accommodation room upgrades
  As a Supplier Admin ISBAT manage accommodation room upgrades

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
  Scenario: Specifying accommodation room upgrade special offers
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And I am on the "special_offers" step of the edit admin "Awesome Accommodation" accommodation page
    And I follow "Add room upgrade"
    And I select "2011-10-01" as the "From" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And I select "2012-10-01" as the "To" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(1)"
    And I select "2011-09-01" as the "From" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And I select "2012-09-01" as the "To" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(1)"
    And I select "2011-08-01" as the "From" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And I select "2012-08-01" as the "To" date within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#room_upgrades > .fields:nth-child(1) .special-offer-date-range .fields:nth-child(3)"

    When I fill in "From room type" with "Suite" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(1)"
    When I fill in "To room type" with "Garage" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(1)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(1)"
    When I fill in "From room type" with "1Suite" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(2)"
    When I fill in "To room type" with "1Garage" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(2)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(1)"
    When I fill in "From room type" with "2Suite" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(3)"
    When I fill in "To room type" with "2Garage" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(3)"

    And I follow "Remove upgrade" within "#room_upgrades > .fields:nth-child(1) #room-upgrade-offer .fields:nth-child(3)"

    And I fill in "Booking code" with "BCRU1234" within "#room_upgrades > .fields:nth-child(1)"
    And I check "Combinable with other offers allowed" within "#room_upgrades > .fields:nth-child(1)"
    And I fill in "Offers allowed to be combined with" with "all of them rooms" within "#room_upgrades > .fields:nth-child(1)"
    And I fill in "Special conditions" with "these are special rooms" within "#room_upgrades > .fields:nth-child(1)"

    When I follow "Add room upgrade"

    And I select "2011-10-01" as the "From" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And I select "2012-10-01" as the "To" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(2)"
    And I select "2011-09-01" as the "From" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And I select "2012-09-01" as the "To" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(2)"
    And I select "2011-08-01" as the "From" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And I select "2012-08-01" as the "To" date within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#room_upgrades > .fields:nth-child(2) .special-offer-date-range .fields:nth-child(3)"

    When I fill in "From room type" with "Suite" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(1)"
    When I fill in "To room type" with "Garage" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(1)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(2)"
    When I fill in "From room type" with "1Suite" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(2)"
    When I fill in "To room type" with "1Garage" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(2)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(2)"
    When I fill in "From room type" with "2Suite" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(3)"
    When I fill in "To room type" with "2Garage" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(3)"
    And I follow "Remove upgrade" within "#room_upgrades > .fields:nth-child(2) #room-upgrade-offer .fields:nth-child(3)"

    And I fill in "Booking code" with "1BCRU1234" within "#room_upgrades > .fields:nth-child(2)"
    And I check "Combinable with other offers allowed" within "#room_upgrades > .fields:nth-child(2)"
    And I fill in "Offers allowed to be combined with" with "1all of them rooms" within "#room_upgrades > .fields:nth-child(2)"
    And I fill in "Special conditions" with "1these are special rooms" within "#room_upgrades > .fields:nth-child(2)"

    When I follow "Add room upgrade"

    And I select "2011-10-01" as the "From" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And I select "2012-10-01" as the "To" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(1)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(3)"
    And I select "2011-09-01" as the "From" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And I select "2012-09-01" as the "To" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(2)"
    And I follow "Add date range" within "#room_upgrades > .fields:nth-child(3)"
    And I select "2011-08-01" as the "From" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And I select "2012-08-01" as the "To" date within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"
    And I follow "Remove date range" within "#room_upgrades > .fields:nth-child(3) .special-offer-date-range .fields:nth-child(3)"

    When I fill in "From room type" with "Suite" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(1)"
    When I fill in "To room type" with "Garage" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(1)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(3)"
    When I fill in "From room type" with "1Suite" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(2)"
    When I fill in "To room type" with "1Garage" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(2)"

    And  I follow "Add upgrade" within "#room_upgrades > .fields:nth-child(3)"
    When I fill in "From room type" with "2Suite" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(3)"
    When I fill in "To room type" with "2Garage" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(3)"
    And I follow "Remove upgrade" within "#room_upgrades > .fields:nth-child(3) #room-upgrade-offer .fields:nth-child(3)"

    And I fill in "Booking code" with "2BCRU1234" within "#room_upgrades > .fields:nth-child(3)"
    And I check "Combinable with other offers allowed" within "#room_upgrades > .fields:nth-child(3)"
    And I fill in "Offers allowed to be combined with" with "2all of them rooms" within "#room_upgrades > .fields:nth-child(3)"
    And I fill in "Special conditions" with "2these are special rooms" within "#room_upgrades > .fields:nth-child(3)"
    And I follow "Remove this room upgrade" within "#room_upgrades > .fields:nth-child(3)"

    When I press "Save & Next"

    Then the "Awesome Accommodation" room upgrades should have the following values:
      | booking_code | special_conditions      | combinable_allowed | combined_offer    |
      | BCRU1234     | these are special rooms | true               | all of them rooms |

    Then the "Awesome Accommodation" room upgrades should not have the following values:
      | booking_code | special_conditions       | combinable_allowed | combined_offer     |
      | 2BCRU1234    | 2these are special rooms | true               | 2all of them rooms |

    And the "Awesome Accommodation" room upgrade "BCRU1234" room upgrade offers should have the following values:
      | from_room_type | to_room_type |
      | Suite          | Garage       |
      | 1Suite         | 1Garage      |
    And the "Awesome Accommodation" room upgrade "BCRU1234" room upgrade offers should not have the following values:
      | from_room_type | to_room_type |
      | 2Suite         | 2Garage      |

    And the "Awesome Accommodation" room upgrade "BCRU1234" room upgrade offers date ranges should have the following values:
      | from       | to         |
      | 2011-10-01 | 2012-10-01 |
      | 2011-09-01 | 2012-09-01 |
    And the "Awesome Accommodation" room upgrade "BCRU1234" room upgrade offers date ranges should not have the following values:
      | from       | to         |
      | 2011-08-01 | 2012-08-01 |

    And the "Awesome Accommodation" room upgrade "1BCRU1234" room upgrade offers should have the following values:
      | from_room_type | to_room_type |
      | Suite          | Garage       |
      | 1Suite         | 1Garage      |
    And the "Awesome Accommodation" room upgrade "1BCRU1234" room upgrade offers should not have the following values:
      | from_room_type | to_room_type |
      | 2Suite         | 2Garage      |

    And the "Awesome Accommodation" room upgrade "1BCRU1234" room upgrade offers date ranges should have the following values:
      | from       | to         |
      | 2011-10-01 | 2012-10-01 |
      | 2011-09-01 | 2012-09-01 |
    And the "Awesome Accommodation" room upgrade "1BCRU1234" room upgrade offers date ranges should not have the following values:
      | from       | to         |
      | 2011-08-01 | 2012-08-01 |
