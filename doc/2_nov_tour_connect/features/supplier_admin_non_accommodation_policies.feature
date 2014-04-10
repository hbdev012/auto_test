Feature: Supplier Admin manage non-accommodation policies
  As a Supplier Admin ISBAT manage non-accommodation policies

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
  Scenario: Specifying non accommodation policy
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And  I am on the "policies" step of the edit admin "Awesome Non Accommodation" non accommodation page
    When I select "1" from "non_accommodation_property_policy_infant_age_from"
    And  I select "3" from "infant_age_to"
    And  I select "3" from "children_age_from"
    And  I select "14" from "non_accommodation_property_policy_children_age_to"
    And  I fill in the following:
      | Adults included in family rate             | 1                        |
      | Children included in family rate           | 2                        |
      | Adults needed before a child can accompany | 3                        |
      | Amount                                     | 3.5                      |
      | Time before usage                          | 24                       |
      | Group policy                               | This is the group policy |
    And  I select "percentage" from "Fee type"
    And  I press "Save & Next"
    Then "Awesome Non Accommodation" property policy should have the following values:
      | infant_age_from   | 1                        |
      | infant_age_to     | 3                        |
      | children_age_from | 3                        |
      | children_age_to   | 14                       |
      | adults_included   | 1                        |
      | children_included | 2                        |
      | adults_needed     | 3                        |
      | fee_type          | percentage               |
      | fee_amount        | 3.5                      |
      | time_before_usage | 24                       |
      | group_policy      | This is the group policy |

  @javascript
  Scenario: policy fee type amount field should reflect selected fee type
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And  I am on the "policies" step of the edit admin "Awesome Non Accommodation" non accommodation page
    When I select "percentage" from "Fee type"
    Then I should see the percent symbol
    And  I should not see the correct currency symbol for "Planet Express"
    When I select "flat fee" from "Fee type"
    Then I should see the correct currency symbol for "Planet Express"
    And  I should not see the percent symbol

  @javascript
  Scenario: children age from should be set when infant age to is selected
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And  I am on the "policies" step of the edit admin "Awesome Non Accommodation" non accommodation page
    And  I select "5" from "infant_age_to"
    Then "children_age_from" should be set to 5
