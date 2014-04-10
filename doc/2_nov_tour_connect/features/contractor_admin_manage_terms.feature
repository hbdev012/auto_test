@javascript
Feature: Contractor admin manage terms
  As a Contractor 
  ISBAT create my terms and conditions set on signup

  Scenario: Fill in terms and submission criteria information
    Given the following companies:
      | name           | _type      | country       |
      | Planet Express | Contractor | United States |
    Given the following users:
      | email         | company_name   | role  | confirmed | pending |
      | user@test.com | Planet Express | admin | true      | false   |
    Given "Planet Express" has valid corporate information
    When  I sign in as "user@test.com/please"
    And   I am on the edit admin terms page
    And I fill in "T&C and Submission criteria set title" with "Primary T&C" within "#terms-sets .fields:nth-child(1)"
    And I fill in "Submission Criteria" with "Primary Criteria" within "#terms-sets .fields:nth-child(1)"
    And I fill in "Terms and Conditions" with "Primary Terms" within "#terms-sets .fields:nth-child(1)"
    And I follow "Add another T&C / Submission criteria set"
    And I fill in "T&C and Submission criteria set title" with "Secondary T&C" within "#terms-sets .fields:nth-child(2)"
    And I fill in "Submission Criteria" with "Secondary Criteria" within "#terms-sets .fields:nth-child(2)"
    And I fill in "Terms and Conditions" with "Secondary Terms" within "#terms-sets .fields:nth-child(2)"
    And I follow "Add another T&C / Submission criteria set"
    And I fill in "T&C and Submission criteria set title" with "Tertiary T&C" within "#terms-sets .fields:nth-child(3)"
    And I fill in "Submission Criteria" with "Tertiary Criteria" within "#terms-sets .fields:nth-child(3)"
    And I fill in "Terms and Conditions" with "Tertiary Terms" within "#terms-sets .fields:nth-child(3)"
    And I follow "Remove this T&C / Submission criteria set" within "#terms-sets .fields:nth-child(3)"
    When I press "Save & Next"
    Then "Planet Express" contractor terms should have the following values:
      | title         | submission_criteria       | terms               |
      | Primary T&C   | Primary Criteria          | Primary Terms       |
      | Secondary T&C | Secondary Criteria        | Secondary Terms     |
    Then "Planet Express" contractor terms should not have the following values:
      | title        | submission_criteria | terms          |
      | Tertiary T&C | Tertiary Criteria   | Tertiary Terms |
