Feature: Supplier Admin manage non-accommodation contracts and billing
  As a Supplier Admin ISBAT manage non-accommodation contracts and billing

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
  Scenario: Specify corporate information
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And I am on the "contracts_and_billing" step of the edit admin "Awesome Non Accommodation" non accommodation page
    And I uncheck "Same as corporate insurance"
    And I fill in "Document name" with "Primary Insurance Doc"
    And I select "2015-01-01" as the "Expiration date" date
    And I attach the file "spec/data/insurance.pdf" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(1)"
    And I follow "Add another insurance document"
    And I attach the file "spec/data/insurance.jpg" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(2)"
    And I follow "Add another insurance document"
    And I attach the file "spec/data/insurance.doc" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(3)"
    And I follow "Remove this document" within "#insurance-documents .fields:nth-child(3)"
    And I uncheck "Same as corporate billing"
    And I fill in the following:
      | Financial Institution | Super Credit Union  |
      | Branch                | North Branch        |
      | BSB/Routing           | 12345678            |
      | Account number        | 87654321            |
      | Account name          | Checking            |
      | IBAN/SWIFT Code       | 12345               |
      | Tax                   | 123                 |
      | Terms                 | These are the terms |
    And I select "United States Dollar" from "Currency"
    And I uncheck "Same as corporate terms"
    And I fill in the following:
      | Enter terms and conditions here: | These are the terms |
    When I press "Save & Preview"
    Then "Awesome Non Accommodation" property billing information should have the following values:
      | bank_name      | Super Credit Union   |
      | branch         | North Branch         |
      | routing_number | 12345678             |
      | account_number | 87654321             |
      | account_name   | Checking             |
      | code           | 12345                |
      | tax            | 123                  |
      | terms          | These are the terms  |
      | currency       | United States Dollar |
    And "Awesome Non Accommodation" property terms should have the following values:
      | terms               |
      | These are the terms |
    And "Awesome Non Accommodation" property insurance information should have the following values:
      | name                  | expires_on |
      | Primary Insurance Doc | 2015-01-01 |
    And "Awesome Non Accommodation" property insurance documents should have the following values:
      | attachment_name |
      | insurance.pdf   |
      | insurance.jpg   |

  @javascript
  Scenario: Specify all corporate information
    Given "Planet Express" has the following non accommodations:
      | name                      |
      | Awesome Non Accommodation |
    And I am on the "contracts_and_billing" step of the edit admin "Awesome Non Accommodation" non accommodation page
    And I uncheck "Same as corporate billing"
    And I fill in the following:
      | Financial Institution | Super Credit Union  |
      | Branch                | North Branch        |
      | BSB/Routing           | 12345678            |
      | Account number        | 87654321            |
      | Account name          | Checking            |
      | IBAN/SWIFT Code       | 12345               |
      | Tax                   | 123                 |
      | Terms                 | These are the terms |
    And I select "United States Dollar" from "Currency"
    And I check "Same as corporate billing"
    And I uncheck "Same as corporate terms"
    And I fill in the following:
      | Enter terms and conditions here: | These are the terms again |
    And I check "Same as corporate terms"
    And I uncheck "Same as corporate insurance"
    And I fill in "Document name" with "Primary Insurance Doc"
    And I select "2015-01-01" as the "Expiration date" date
    And I attach the file "spec/data/insurance.pdf" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(1)"
    And I follow "Add another insurance document"
    And I attach the file "spec/data/insurance.jpg" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(2)"
    And I follow "Add another insurance document"
    And I attach the file "spec/data/insurance.doc" to "Select a file from your computer" within "#insurance-documents .fields:nth-child(3)"
    And I follow "Remove this document" within "#insurance-documents .fields:nth-child(3)"
    And I check "Same as corporate insurance"
    When I press "Save & Preview"
    And "Awesome Non Accommodation" property billing information should be the same as corporate
    And "Awesome Non Accommodation" property terms should be the same as corporate
    And "Awesome Non Accommodation" property insurance information should be the same as corporate
