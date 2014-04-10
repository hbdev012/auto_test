Feature: Supplier Admin manage accommodation ratings
  As a Supplier Admin ISBAT manage accommodation ratings

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    And "Planet Express" has valid billing information
    And I sign in as "admin@test.com/please"

  Scenario: Specifying accommodation rating
    Given "Planet Express" has the following accommodations:
     | name                  |
     | Awesome Accommodation |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    And  I fill in "Stars" with "4"
    And  I choose "Official AAAT/Qualmark"
    When I press "Save & Next"
    And "Awesome Accommodation" accommodation ratings should have the following values:
      | rating      | 4                      |
      | rating_type | Official AAAT/Qualmark |
    When I go to "ratings_and_amenities" step of the edit admin "Awesome Accommodation" accommodation page
    And  I choose "Self assessed"
    And  I press "Save & Next"
    Then "Awesome Accommodation" accommodation ratings should have the following values:
      | rating      | 4             |
      | rating_type | Self assessed |

