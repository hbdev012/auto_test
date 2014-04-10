Feature: Contractor admin manage corporate information
  As a Contractor Admin
  I should be able to manage corporate information

  Background:
    Given I am on the sign up page
    And I choose "Contractor"
    And I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And  I check "I agree with TourConnect Terms & Privacy Policy"
    And  I press "Sign up"
    And  "user@test.com" opens the email with subject "Confirmation instructions"
    And  they click the first link in the email

  Scenario: Confirmation of account leads to corporate information signup
    Then I should be on the edit admin signup page
    And  I should not see "What type of product do you offer?"
    And  I should not see "Do you offer your products direct from your Corporate office?"
    And  I should not see "Enter terms and conditions here:"
    And  I should not see "Upload insurance document"

  @javascript
  Scenario: Corporate information interface
    Then I should see "Planet Express" within "#company-name"
    And  I should see an administrator default contact group
    And  I should see a sales default contact group
    And  I should see a billing default contact group
    And  I should see a reservations default contact group

  @javascript
  Scenario: Fill in corporate information (valid)
    When I attach the file "spec/data/logo.png" to "Select a logo from your computer"
    And  I fill in the following:
      | Write a brief description about your company | This is the best company ever |
      | Corporate identification number              | 123456AB                      |
      | Website                                      | http://test.com/              |
      | Fax                                          | 602-123-4567                  |
      | Phone                                        | 602-123-4568                  |
      | Address                                      | 123 Main St.                  |
      | Address (line 2)                             | Suite 101                     |
      | City                                         | Somewhere                     |
      | State/Province/Region                        | CA                            |
      | Zip/Postal Code                              | 90210                         |
    And I select "United States" from "Country"
    And I fill in the administrator contact information
    And I fill in the sales contact
    And I fill in another sales contact
    And I fill in another sales contact
    And I remove the last sales contact
    And I fill in the billing contact
    And I fill in another billing contact
    And I fill in another billing contact
    And I remove the last billing contact
    And I fill in the reservations contact
    And I fill in another reservations contact
    And I fill in another reservations contact
    And I remove the last reservations contact
    And I add the legal contact group
    And I fill in the legal contact
    And I fill in another legal contact
    And I fill in another legal contact
    And I remove the last legal contact
    And I add the unnecessary contact group
    And I remove the unnecessary contact group
    And I press "Save & Next"
    Then I should be on the edit admin terms page
    And "Planet Express" corporate information should have the following values:
      | description     | This is the best company ever |
    And "Planet Express" location should have the following values:
      | address_1            | 123 Main St.     |
      | address_2            | Suite 101        |
      | city                 | Somewhere        |
      | state                | CA               |
      | postal_code          | 90210            |
      | country              | United States    |
      | corporate_identifier | 123456AB         |
      | uri                  | http://test.com/ |
      | fax_number           | 602-123-4567     |
      | phone_number         | 602-123-4568     |
    And "Planet Express" should have a logo named "logo.png"
    And "Planet Express" contact groups should have the following values:
      | name          | initial_group | admin_group |
      | Administrator | true          | true        |
      | Sales         | true          | false       |
      | Billing       | true          | false       |
      | Reservations  | true          | false       |
      | Legal         | false         | false       |
    And "Planet Express" contact groups should not have the following values:
      | name        |
      | Unnecessary |
    And "Planet Express" contacts should have the following values:
      | contact_group | first_name     | last_name | email                   | phone_number | fax_number   |
      | Administrator | Testy          | McUserton | user@test.com           | 602-123-4567 | 602-123-4568 |
      | Sales         | Sales          | Contact   | sales@test.com          | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing        | Contact   | billing@test.com        | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations   | Contact   | reservations@test.com   | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal          | Contact   | legal@test.com          | 602-123-4567 | 602-123-4568 |
      | Sales         | Sales1         | Contact   | sales1@test.com         | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing1       | Contact   | billing1@test.com       | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations1  | Contact   | reservations1@test.com  | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal1         | Contact   | legal1@test.com         | 602-123-4567 | 602-123-4568 |

  Scenario: Editing corporate information
    Given the following users:
      | email          | company_name   | role  | confirmed | pending |
      | admin@test.com | Planet Express | admin | true      | false   |
    Given I sign in as "admin@test.com/please"
    And I follow "Edit Corporate Information"
    Then I should see "Step One: Corporate Information"
    And I should see "Planet Express"
    When I follow "Billing Information"
    Then I should see "Step Two: Billing Information"
    When I follow "Payment Information"
    Then I should see "Step Three: Payment Information"
