Feature: Supplier Admin manage non accommodation seasons
  As a Supplier Admin ISBAT manage non accommodation seasons

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
  Scenario: Specifying non accommodation seasons
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    When I go to "seasons" step of the edit admin "Awesome Non Accommodation" non accommodation page

    And I follow "Add a season"
    And I fill in "Name" with "Winter" within "#seasons > .fields:nth-child(1)"
    And I select "2011-10-01" as the "From" date within "#seasons > .fields:nth-child(1)"
    And I select "2012-02-01" as the "To" date within "#seasons > .fields:nth-child(1)"
    And I fill in "Name" with "Christmas Holiday" within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(1)"
    And I select "2011-12-24" as the "From" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(1)"
    And I select "2011-12-26" as the "To" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(1)"
    And I follow "Add a blackout period" within "#seasons > .fields:nth-child(1)"
    And I fill in "Name" with "New Year's Holiday" within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(2)"
    And I select "2011-12-31" as the "From" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(2)"
    And I select "2012-01-02" as the "To" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(2)"
    And I follow "Add a blackout period" within "#seasons > .fields:nth-child(1)"
    And I fill in "Name" with "Valentine's Day" within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(3)"
    And I select "2012-02-14" as the "From" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(3)"
    And I select "2012-02-14" as the "To" date within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(3)"
    And I follow "Remove this blackout" within "#seasons > .fields:nth-child(1) #blackouts > .fields:nth-child(3)"
    And I fill in "Name" with "Christmas Special" within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(1)"
    And I select "2011-12-20" as the "From" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(1)"
    And I select "2011-12-23" as the "To" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(1)"
    And I follow "Add a special pricing period" within "#seasons > .fields:nth-child(1)"
    And I fill in "Name" with "New Year's Special" within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(2)"
    And I select "2011-12-28" as the "From" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(2)"
    And I select "2011-12-30" as the "To" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(2)"
    And I follow "Add a special pricing period" within "#seasons > .fields:nth-child(1)"
    And I fill in "Name" with "Valentine's Day Special" within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(3)"
    And I select "2012-02-14" as the "From" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(3)"
    And I select "2012-02-14" as the "To" date within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(3)"
    And I follow "Remove this special pricing" within "#seasons > .fields:nth-child(1) #special-pricing > .fields:nth-child(3)"

    And I follow "Add a season"
    And I fill in "Name" with "Summer" within "#seasons > .fields:nth-child(2)"
    And I select "2012-05-01" as the "From" date within "#seasons > .fields:nth-child(2)"
    And I select "2012-08-01" as the "To" date within "#seasons > .fields:nth-child(2)"
    And I fill in "Name" with "Cinco de Mayo" within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(1)"
    And I select "2012-05-05" as the "From" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(1)"
    And I select "2012-05-05" as the "To" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(1)"
    And I follow "Add a blackout period" within "#seasons > .fields:nth-child(2)"
    And I fill in "Name" with "July 4th" within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(2)"
    And I select "2012-07-04" as the "From" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(2)"
    And I select "2012-07-04" as the "To" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(2)"
    And I follow "Add a blackout period" within "#seasons > .fields:nth-child(2)"
    And I fill in "Name" with "???" within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(3)"
    And I select "2012-07-30" as the "From" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(3)"
    And I select "2012-07-30" as the "To" date within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(3)"
    And I follow "Remove this blackout" within "#seasons > .fields:nth-child(2) #blackouts > .fields:nth-child(3)"
    And I fill in "Name" with "Cinco de Mayo Special" within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(1)"
    And I select "2012-05-04" as the "From" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(1)"
    And I select "2012-05-04" as the "To" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(1)"
    And I follow "Add a special pricing period" within "#seasons > .fields:nth-child(2)"
    And I fill in "Name" with "July 4th Special" within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(2)"
    And I select "2012-07-03" as the "From" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(2)"
    And I select "2012-07-03" as the "To" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(2)"
    And I follow "Add a special pricing period" within "#seasons > .fields:nth-child(2)"
    And I fill in "Name" with "??? Special" within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(3)"
    And I select "2012-07-30" as the "From" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(3)"
    And I select "2012-07-30" as the "To" date within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(3)"
    And I follow "Remove this special pricing" within "#seasons > .fields:nth-child(2) #special-pricing > .fields:nth-child(3)"

    And I follow "Add a season"
    And I fill in "Name" with "Fall" within "#seasons > .fields:nth-child(3)"
    And I select "2012-08-01" as the "From" date within "#seasons > .fields:nth-child(3)"
    And I select "2012-10-01" as the "To" date within "#seasons > .fields:nth-child(3)"
    And I follow "Remove this season" within "#seasons > .fields:nth-child(3)"

    And I press "Save & Next"
    Then the "Awesome Non Accommodation" seasons should have the following values:
      | name   | begins_on  | ends_on    |
      | Winter | 2011-10-01 | 2012-02-01 |
      | Summer | 2012-05-01 | 2012-08-01 |
    And the "Awesome Non Accommodation" seasons should not have the following values:
      | name |
      | Fall |
    And the "Awesome Non Accommodation" season "Winter" should have the following blackout periods:
      | name               | begins_on  | ends_on    |
      | Christmas Holiday  | 2011-12-24 | 2011-12-26 |
      | New Year's Holiday | 2011-12-31 | 2012-01-02 |
    And the "Awesome Non Accommodation" season "Winter" should not have the following blackout periods:
      | name            |
      | Valentine's Day |
    And the "Awesome Non Accommodation" season "Winter" should have the following special pricing periods:
      | name               | begins_on  | ends_on    |
      | Christmas Special  | 2011-12-20 | 2011-12-23 |
      | New Year's Special | 2011-12-28 | 2011-12-30 |
    And the "Awesome Non Accommodation" season "Winter" should not have the following blackout periods:
      | name                    |
      | Valentine's Day Special |
    And the "Awesome Non Accommodation" season "Summer" should have the following blackout periods:
      | name          | begins_on  | ends_on    |
      | Cinco de Mayo | 2012-05-05 | 2012-05-05 |
      | July 4th      | 2012-07-04 | 2012-07-04 |
    And the "Awesome Non Accommodation" season "Summer" should not have the following blackout periods:
      | name |
      | ???  |
    And the "Awesome Non Accommodation" season "Summer" should have the following special pricing periods:
      | name                  | begins_on  | ends_on    |
      | Cinco de Mayo Special | 2012-05-04 | 2012-05-04 |
      | July 4th Special      | 2012-07-03 | 2012-07-03 |
    And the "Awesome Non Accommodation" season "Summer" should not have the following special pricing periods:
      | name        |
      | ??? Special |

  @javascript
  Scenario: Displaying season length warning (no seasons)
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And   it is the year 2011
    When  I go to "seasons" step of the edit admin "Awesome Non Accommodation" non accommodation page
    Then  I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And   "#gap-message" should be visible

  @javascript
  Scenario: Displaying season length warning (gap)
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following seasons:
      | name            | begins_on  | ends_on    |
      | Mostly All Year | 2011-01-02 | 2011-12-31 |
    When I go to "seasons" step of the edit admin "Awesome Non Accommodation" non accommodation page
    Then  I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And   "#gap-message" should be visible
    When  I press "Save & Next"
    Then  I should see "Step Three: Seasons"
    And   I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And   "#gap-message" should be visible

  @javascript
  Scenario: Displaying season length warning (multiple gaps)
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following seasons:
      | name | begins_on  | ends_on    |
      | Q1   | 2011-01-02 | 2011-02-28 |
      | Q4   | 2011-11-02 | 2011-12-31 |
    When I go to "seasons" step of the edit admin "Awesome Non Accommodation" non accommodation page
    Then  I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And   "#gap-message" should be visible
    When  I press "Save & Next"
    Then  I should see "Step Three: Seasons"
    And   I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And   "#gap-message" should be visible

  @javascript
  Scenario: Not displaying season length warning
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And "Awesome Non Accommodation" has the following seasons:
      | name     | begins_on  | ends_on    |
      | All Year | 2011-01-01 | 2011-12-31 |
    When I go to "seasons" step of the edit admin "Awesome Non Accommodation" non accommodation page
    Then I should see "Error: Seasons don't span the calendar year, please arrange your seasons to fill the entire year."
    And  "#gap-message" should not be visible
    When I press "Save & Next"
    Then I should see "Step Four: Special Offers"
