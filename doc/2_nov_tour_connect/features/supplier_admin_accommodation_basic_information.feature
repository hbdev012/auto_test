Feature: Supplier Admin manage accommodation basic information
  As a Supplier Admin ISBAT manage accommodation basic information

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
  Scenario: Adding a new accommodation
    When I am on the new admin accommodation page
    And  I fill in the following:
      | Name                  | Awesome Accommodation  |
      | Short description     | This is my...          |
      | Long description      | This is my description |
      | Address               | 123 Main St.           |
      | Address (line 2)      | Suite 101              |
      | City                  | Somewhere              |
      | State/Province/Region | CA                     |
      | Zip/Postal Code       | 90210                  |
      | Website               | http://test.com/       |
      | Fax                   | 602-123-4567           |
      | Phone                 | 602-123-4568           |
    And I check "Conforms to EU Regulations"
    And I select "United States" from "Country"
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
    When I press "Save & Next"
    Then I should see "Step Two: Ratings and Amenities"
    And  "Planet Express" properties should have the following values:
      | name                  | short_description | long_description       | conforms_to_eu |
      | Awesome Accommodation | This is my...     | This is my description | true           |
    And "Awesome Accommodation" property location should have the following values:
      | address_1    | 123 Main St.     |
      | address_2    | Suite 101        |
      | city         | Somewhere        |
      | state        | CA               |
      | postal_code  | 90210            |
      | country      | United States    |
      | uri          | http://test.com/ |
      | fax_number   | 602-123-4567     |
      | phone_number | 602-123-4568     |
    And "Awesome Accommodation" property contact groups should have the following values:
      | name         | initial_group | admin_group |
      | Sales        | true          | false       |
      | Billing      | true          | false       |
      | Reservations | true          | false       |
      | Legal        | false         | false       |
    And "Awesome Accommodation" property contact groups should not have the following values:
      | name        |
      | Unnecessary |
    And "Awesome Accommodation" property contacts should have the following values:
      | contact_group | first_name    | last_name | email                  | phone_number | fax_number   |
      | Sales         | Sales         | Contact   | sales@test.com         | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing       | Contact   | billing@test.com       | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations  | Contact   | reservations@test.com  | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal         | Contact   | legal@test.com         | 602-123-4567 | 602-123-4568 |
      | Sales         | Sales1        | Contact   | sales1@test.com        | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing1      | Contact   | billing1@test.com      | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations1 | Contact   | reservations1@test.com | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal1        | Contact   | legal1@test.com        | 602-123-4567 | 602-123-4568 |

  @javascript
  Scenario: Adding a new accommodation with all corporate information
    When I am on the new admin accommodation page
    And  I fill in the following:
      | Name                  | Awesome Accommodation  |
      | Short description     | This is my...          |
      | Long description      | This is my description |
      | Address               | 123 Main St.           |
      | Address (line 2)      | Suite 101              |
      | City                  | Somewhere              |
      | State/Province/Region | CA                     |
      | Zip/Postal Code       | 90210                  |
      | Website               | http://test.com/       |
      | Fax                   | 602-123-4567           |
      | Phone                 | 602-123-4568           |
    And I check "Conforms to EU Regulations"
    And I select "United States" from "Country"
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
    When I press "Save & Next"
    Then I should see "Step Two: Ratings and Amenities"
    And  "Planet Express" properties should have the following values:
      | name                  | short_description | long_description       | conforms_to_eu |
      | Awesome Accommodation | This is my...     | This is my description | true           |
    And "Awesome Accommodation" property location should have the following values:
      | address_1    | 123 Main St.     |
      | address_2    | Suite 101        |
      | city         | Somewhere        |
      | state        | CA               |
      | postal_code  | 90210            |
      | country      | United States    |
      | uri          | http://test.com/ |
      | fax_number   | 602-123-4567     |
      | phone_number | 602-123-4568     |
    And "Awesome Accommodation" property contact groups should have the following values:
      | name         | initial_group | admin_group |
      | Sales        | true          | false       |
      | Billing      | true          | false       |
      | Reservations | true          | false       |
      | Legal        | false         | false       |
    And "Awesome Accommodation" property contact groups should not have the following values:
      | name        |
      | Unnecessary |
    And "Awesome Accommodation" property contacts should have the following values:
      | contact_group | first_name    | last_name | email                  | phone_number | fax_number   |
      | Sales         | Sales         | Contact   | sales@test.com         | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing       | Contact   | billing@test.com       | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations  | Contact   | reservations@test.com  | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal         | Contact   | legal@test.com         | 602-123-4567 | 602-123-4568 |
      | Sales         | Sales1        | Contact   | sales1@test.com        | 602-123-4567 | 602-123-4568 |
      | Billing       | Billing1      | Contact   | billing1@test.com      | 602-123-4567 | 602-123-4568 |
      | Reservations  | Reservations1 | Contact   | reservations1@test.com | 602-123-4567 | 602-123-4568 |
      | Legal         | Legal1        | Contact   | legal1@test.com        | 602-123-4567 | 602-123-4568 |

  @javascript
  Scenario: Specifying accommodation photos
    Given "Planet Express" has the following accommodations:
      | name                  |
      | Awesome Accommodation |
    And  I am on the "basic_information" step of the edit admin "Awesome Accommodation" accommodation page
    When I follow "Add an image"
    And  I attach the file "spec/data/logo.png" to "Select from your computer" within ".images .fields:nth-child(1)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.jpg" to "Select from your computer" within ".images .fields:nth-child(2)"
    And  I follow "Add an image"
    And  I attach the file "spec/data/logo.gif" to "Select from your computer" within ".images .fields:nth-child(3)"
    And  I follow "Remove this image" within ".images .fields:nth-child(3)"
    And  I press "Save & Next"
    Then "Awesome Accommodation" property images should have the following values:
      | attachment_name |
      | logo.png        |
      | logo.jpg        |
    And "Awesome Accommodation" property images should not have the following values:
      | attachment_name |
      | logo.gif        |
