Feature: Supplier admin manage billing information

  Scenario: Fill in billing information
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email         | company_name   | role  | confirmed | pending |
      | user@test.com | Planet Express | admin | true      | false   |
    Given "Planet Express" has valid corporate information
    When  I sign in as "user@test.com/please"
    And   I am on the edit admin billing information page
    And   I fill in the following:
      | Financial Institution | Super Credit Union  |
      | Branch                | North Branch        |
      | BSB/Routing           | 12345678            |
      | Account number        | 87654321            |
      | Account name          | Checking            |
      | IBAN/SWIFT Code       | 12345               |
      | Tax                   | 123                 |
      | Terms                 | These are the terms |
    And  I select "United States Dollar" from "Currency"
    When I press "Save & Next"
    Then "Planet Express" billing information should have the following values:
      | bank_name      | Super Credit Union   |
      | branch         | North Branch         |
      | routing_number | 12345678             |
      | account_number | 87654321             |
      | account_name   | Checking             |
      | code           | 12345                |
      | tax            | 123                  |
      | terms          | These are the terms  |
      | currency       | United States Dollar |
    When I am on the edit admin billing information page
    And   I fill in the following:
      | Financial Institution | Awesome Credit Union    |
      | Branch                | South Branch            |
      | BSB/Routing           | 87654321                |
      | Account number        | 12343213                |
      | Account name          | Savings                 |
      | IBAN/SWIFT Code       | 324322932               |
      | Tax                   | 5                       |
      | Terms                 | These are the old terms |
    And  I select "Australian Dollar" from "Currency"
    When I press "Save & Next"
    Then "Planet Express" billing information should have the following values:
      | bank_name      | Awesome Credit Union    |
      | branch         | South Branch            |
      | routing_number | 87654321                |
      | account_number | 12343213                |
      | account_name   | Savings                 |
      | code           | 324322932               |
      | tax            | 5                       |
      | terms          | These are the old terms |
      | currency       | Australian Dollar       |
