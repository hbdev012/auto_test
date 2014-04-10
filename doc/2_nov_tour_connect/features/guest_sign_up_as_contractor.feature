Feature: Sign up
  As a guest
  I should be able to sign up as a Contractor
  So that I can access restricted areas of the site

  Background:
    Given I am not logged in
    And I am on the home page
    And I go to the sign up page

  Scenario: Contractor signs up with valid data
    Given I choose "Contractor"
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
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed" 
    And  "user@test.com" should be the creator of "Planet Express" in "United States"
    And  "user@test.com" should be an admin
    And  "Planet Express" in "United States" should be a contractor

  Scenario: Contractor signs up with invalid email
    Given I choose "Contractor"
    And I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | invalidemail   |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    Then I should see "Email is invalid"

  Scenario: Contractor signs up without password
    Given I choose "Contractor"
    And I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              |                |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    Then I should see "Password can't be blank"

  Scenario: Contractor signs up without password confirmation
    Given I choose "Contractor"
    And I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation |                |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"

  Scenario: Contractor signs up with mismatched password and confirmation
    Given I choose "Contractor"
    And I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation | please1        |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"

  Scenario: Contractor signs up with existing company name
    Given I choose "Contractor"
    And   I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    When I am on the home page
    And  I go to the sign up page
    And  I choose "Contractor"
    And  I fill in the following:
      | First name            | Copy           |
      | Last name             | Cat            |
      | Email                 | cat@test.com   |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And  I check "I agree with TourConnect Terms & Privacy Policy"
    And  I press "Sign up"
    Then I should see "We have also notified the administrator of your request to join the company."
    And  "cat@test.com" is a pending user for "Planet Express" in "United States"
    And  "cat@test.com" should not be an admin
    And  "cat@test.com" should receive no emails with subject "Confirmation instructions"
    And  "user@test.com" should receive an email with subject "Copy Cat requested to join your company"

  Scenario: Contractor signs up with existing company name in a different country
    Given I choose "Contractor"
    And   I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    When I am on the home page
    And  I go to the sign up page
    And  I choose "Contractor"
    And  I fill in the following:
      | First name            | Copy           |
      | Last name             | Cat            |
      | Email                 | cat@test.com   |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And  I select "Australia" from "Country"
    And  I check "I agree with TourConnect Terms & Privacy Policy"
    And  I press "Sign up"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed" 
    And  "cat@test.com" should be the creator of "Planet Express" in "Australia"
    And  "cat@test.com" should be an admin
    And  "Planet Express" in "Australia" should be a contractor
    And  "cat@test.com" should receive an email with subject "Confirmation instructions"
    And  "user@test.com" should receive no emails with subject "Copy Cat requested to join your company"

  Scenario: Contractor signs up with existing company name (invalid)
    Given I choose "Contractor"
    And   I fill in the following:
      | First name            | Testy          |
      | Last name             | McUserton      |
      | Email                 | user@test.com  |
      | Password              | please         |
      | Password confirmation | please         |
      | Company name          | Planet Express |
      | Job title             | Delivery Boy   |
    And I check "I agree with TourConnect Terms & Privacy Policy"
    And I press "Sign up"
    When I am on the home page
    And  I go to the sign up page
    And  I choose "Contractor"
    And  I fill in the following:
      | Company name          | Planet Express |
    And  I press "Sign up"
    Then I should see "errors prohibited this record from being saved"

  @javascript
  Scenario: Company name autocomplete active with 3 or more characters
    Given the following companies:
      | name               | _type      | country       |
      | Planet Express     | Contractor | United States |
      | Planet of the apes | Supplier   | United States |
    Given I choose "Contractor"
    And  I fill in "Company name" with "Pl"
    Then I should not see "Planet Express"
    And  I should not see "Planet of the apes"

  @javascript
  Scenario: Company name autocomplete should find company names that begin with search term
    Given the following companies:
      | name               | _type      | country       |
      | Planet Express     | Contractor | United States |
      | Planet of the apes | Supplier   | United States |
      | Wicked Planet      | Contractor | United States |
    Given I choose "Contractor"
    And  I fill in "Company name" with "Planet"
    Then I should see "Planet Express"
    Then I should not see "Wicked Planet"
    And  I should not see "Planet of the apes"

  @javascript
  Scenario: Company name autocomplete limited to 5 results
    Given the following companies:
      | name               | _type      | country       |
      | Planet Express     | Contractor | United States |
      | Planet of the apes | Supplier   | United States |
      | Planet Wicked      | Contractor | United States |
      | Planet Hollywood   | Contractor | United States |
      | Planet Pizza       | Contractor | United States |
      | Planet Taco        | Contractor | United States |
      | Planet Awesome     | Contractor | United States |
    Given I choose "Contractor"
    And  I fill in "Company name" with "Planet"
    Then I should see "Planet Awesome"
    And  I should see "Planet Express"
    And  I should see "Planet Hollywood"
    And  I should see "Planet Pizza"
    And  I should see "Planet Taco"
    And  I should not see "Planet Wicked"
    And  I should not see "Planet of the apes"

  @javascript
  Scenario: Signing up as a Contractor choosing from an existing company
    Given the following companies:
      | name               | _type      | country       |
      | Planet Express     | Contractor | United States |
      | Planet of the apes | Supplier   | United States |
    And  I choose "Contractor"
    And  I fill in the following:
      | First name            | Copy           |
      | Last name             | Cat            |
      | Email                 | cat@test.com   |
      | Password              | please         |
      | Password confirmation | please         |
      | Job title             | Delivery Boy   |
    And  I check "I agree with TourConnect Terms & Privacy Policy"
    And  I fill in "Company name" with "Pla"
    And  I wait for the AJAX call to finish
    Then I should see "Planet Express"
    And  I should not see "Planet of the apes"
    When I click the link with text "Planet Express, United States"
    And  I wait for the AJAX call to finish
    Then the company name field should be replaced with the selected company "Planet Express/United States"
    When I press "Sign up"
    Then I should see "We have also notified the administrator of your request to join the company."
    And  "cat@test.com" is a pending user for "Planet Express" in "United States"

  @javascript
  Scenario: Signing up as a Contractor choosing from an existing company, then de-select
  Given the following companies:
    | name               | _type      | country       |
    | Planet Express     | Contractor | United States |
    | Planet of the apes | Supplier   | United States |
  And I choose "Contractor"
  And I fill in the following:
    | First name            | Copy           |
    | Last name             | Cat            |
    | Email                 | cat@test.com   |
    | Password              | please         |
    | Password confirmation | please         |
    | Job title             | Delivery Boy   |
  And  I check "I agree with TourConnect Terms & Privacy Policy"
  And  I fill in "Company name" with "Pla"
  And  I wait for the AJAX call to finish
  When I click the link with text "Planet Express, United States"
  And  I wait for the AJAX call to finish
  When I click the link with text "This is not my company" within "#selected-company"
  Then the selected company "Planet Express/United States" should be replaced with the company name field
  When I fill in "Company name" with "Dev Fu"
  When I press "Sign up"
  Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed" 
  And  "cat@test.com" should be the creator of "Dev Fu" in "United States"
  And  "cat@test.com" should be an admin
  And  "Dev Fu" in "United States" should be a contractor

  @javascript
  Scenario: Signing up as a contractor and rejecting all existing companies
    Given the following companies:
      | name               | _type      | country       |
      | Planet Express     | Contractor | United States |
      | Planet of the apes | Supplier   | United States |
      | Planet Wicked      | Contractor | United States |
      | Planet Hollywood   | Contractor | United States |
      | Planet Pizza       | Contractor | United States |
      | Planet Taco        | Contractor | United States |
      | Planet Awesome     | Contractor | United States |
    And I choose "Contractor"
    And I fill in the following:
      | First name            | Copy           |
      | Last name             | Cat            |
      | Email                 | cat@test.com   |
      | Password              | please         |
      | Password confirmation | please         |
      | Job title             | Delivery Boy   |
    And  I check "I agree with TourConnect Terms & Privacy Policy"
    And  I fill in "Company name" with "Pla"
    When I click the link with text "No, none of these are my company"
    Then ".ui-autocomplete" should not be visible
    When I fill in "Company name" with "Planet"
    Then I should see "Planet Express"
    When I click the link with text "No, none of these are my company"
    When I press "Sign up"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed" 
    And  "cat@test.com" should be the creator of "Planet" in "United States"
    And  "cat@test.com" should be an admin
    And  "Planet" in "United States" should be a contractor

