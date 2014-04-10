Feature: Supplier Admin non accommodation navigation
  As a Supplier Admin ISBAT navigate within a non accommodation

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
  Scenario: New Non Accommodation Navigation
    When I am on the new admin non accommodation page
    And I follow "Property Description and Location"
    And I follow "Contacts"

  @javascript
  Scenario: Edit Non Accommodation Navigation
    Given "Planet Express" has the following non accommodations:
     | name                      |
     | Awesome Non Accommodation |
   And I am on the "basic_information" step of the edit admin "Awesome Non Accommodation" non accommodation page
   When I follow "Basic Information"
   Then I should see "Step One: Basic Information"
   And I follow "Property Description and Location"
   And I follow "Contacts"

   And I follow "Policies"
   Then I should see "Step Two: Policies"

   And I follow "Seasons"
   Then I should see "Step Three: Seasons"

   And I follow "Special Offers"
   Then I should see "Step Four: Special Offers"
   And I follow "Bonus Offers"

   And I follow "Contracts and Billing"
   Then I should see "Step Five: Contracts and Billing"
   And I follow "Property Insurance"
   And I follow "Property Billing Information"
   And I follow "Property Terms and Conditions"

 Scenario: Viewing last saved date on new page
   Given I am on the new admin non accommodation page
   Then  I should see "Last Save: Never"

 Scenario: Viewing last saved date on edit page
   Given "Planet Express" has the following non accommodations:
    | name                      |
    | Awesome Non Accommodation |
   And  I go to "policies" step of the edit admin "Awesome Non Accommodation" non accommodation page
   Then I should see "Last Save: less than a minute ago"

