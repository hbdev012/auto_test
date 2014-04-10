Feature: User create invitations
  As a User ISBAT invite new users

  Background:
    Given the following companies:
      | name           | _type    | country       |
      | Planet Express | Supplier | United States |
    Given the following users:
      | email         | first_name | last_name | company_name   | role | confirmed | pending |
      | user@test.com | Joe        | User      | Planet Express |      | true      | false   |
    And I sign in as "user@test.com/please"

  Scenario: Inviting a single user with name
    When I follow "New Invitation"
    And I fill in the following:
      | Company name | New Super Company |
      | Email        | invited@test.com  |
      | First name   | Invited           |
      | Last name    | User              |
    When I press "Send Invitation"
    Then I should see "Invitation sent."
    And the invitation "invited@test.com" should have the following values:
      | company_name      | email            | first_name | last_name |
      | New Super Company | invited@test.com | Invited    | User      |
    When I sign out
    And the invitation mail process is run
    Then  "invited@test.com" should receive an email with subject "Invitation to join TourConnect"
    And  "invited@test.com" opens the email
    And  they should see "To: Invited User" in the email body
    And  they should see "From: Joe User" in the email body
    And  they click the first link in the email
    Then I should be on the sign up page
    And  the "Email" field should contain "invited@test.com"
    And  the "First name" field should contain "Invited"
    And  the "Last name" field should contain "User"
    And  the "Company name" field should contain "New Super Company"

  Scenario: Attempting to invite a single user again
    Given the following invitations:
      | company_name | email        | first_name | last_name | status  |
      | UPS          | ups@test.com | newinvite  | company   | invited |
    When I follow "New Invitation"
    And I fill in the following:
      | Company name | UPS          |
      | Email        | ups@test.com |
      | First name   | newinvite    |
      | Last name    | company      |
    When I press "Send Invitation"
    Then I should see "Email is invalid - An invitation has already been sent to that email"

  Scenario: Inviting users in bulk via CSV
    When I follow "New Invitation"
    And  I attach the file "spec/data/invite_list.csv" to "Select a file from your computer"
    And  I press "Send Invitation"
    Then I should see "Processing invitations, you will receive a status notification email upon completion"

    When I follow "New Invitation"
    And  I attach the file "spec/data/invite_list2.csv" to "Select a file from your computer"
    And  I press "Send Invitation"
    Then I should see "Processing invitations, you will receive a status notification email upon completion"

    And invitations should have the following values:
      | company_name  | email                  | first_name | last_name |
      | company_one   | company_one@test.com   | company    | one       |
      | company_two   | company_two@test.com   | company    | two       |
      | company_three | company_three@test.com | company    | three     |
      | company_four  | company_four@test.com  | company    | four      |
      | company_five  | company_five@test.com  | company    | five      |
      | company_six   | company_six@test.com   | company    | six       |
      | company_seven | company_seven@test.com | company    | seven     |
      | company_eight | company_eight@test.com | company    | eight     |

    When the invitation mail process is run
    Then "company_one@test.com" should receive an email with subject "Invitation to join TourConnect"
    And  "company_two@test.com" should receive an email with subject "Invitation to join TourConnect"
    And  "company_three@test.com" should receive an email with subject "Invitation to join TourConnect"
    And  "company_four@test.com" should receive an email with subject "Invitation to join TourConnect"

    When I sign out
    And  "company_two@test.com" opens the email with subject "Invitation to join TourConnect"
    Then they should see "To: company two" in the email body
    And  they should see "From: Joe User" in the email body

    When they click the first link in the email
    Then I should be on the sign up page
    And  the "Email" field should contain "company_two@test.com"
    And  the "First name" field should contain "company"
    And  the "Last name" field should contain "two"
    And  the "Company name" field should contain "company_two"

    When "company_seven@test.com" opens the email with subject "Invitation to join TourConnect"
    Then they should see "To: company seven" in the email body
    And  they should see "From: Joe User" in the email body
    When they click the first link in the email
    Then I should be on the sign up page
    And  the "Email" field should contain "company_seven@test.com"
    And  the "First name" field should contain "company"
    And  the "Last name" field should contain "seven"
    And  the "Company name" field should contain "company_seven"

  Scenario: Inviter receives summary email
    Given the following invitations:
      | company_name | email        | first_name | last_name |
      | Two          | two@test.com | company    | two       |
    Given the following invitations by "user@test.com":
      | company_name | email          | first_name | last_name | group_id |
      | One          | one@test.com   | company    | one       | ABC123   |
      | Two          | two@test.com   | company    | two       | ABC123   |
      | Three        | three@test.com | company    | three     | ABC123   |
      | Four         |                | company    | four      | XYZ123   |
      | Five         | five@test.com  | company    | five      | XYZ123   |
    And  the invitation mail process is run
    When "user@test.com" opens the email with subject "Invitation Summary: 3 invitations processed"
    And  they should see "Processed: 3" in the email body
    And  they should see "Invited: 2" in the email body
    And  they should see "Already Invited: 1" in the email body
    And  they should see "Invalid: 0" in the email body
    And  they should see "Failed: 0" in the email body
    Then they should see an attachment with the email
    And  the attachment should contain:
      | company_name | email          | first_name | last_name | status          |
      | One          | one@test.com   | company    | one       | invited         |
      | Two          | two@test.com   | company    | two       | already invited |
      | Three        | three@test.com | company    | three     | invited         |
    When "user@test.com" opens the email with subject "Invitation Summary: 2 invitations processed"
    And  they should see "Processed: 2" in the email body
    And  they should see "Invited: 1" in the email body
    And  they should see "Already Invited: 0" in the email body
    And  they should see "Invalid: 1" in the email body
    And  they should see "Failed: 0" in the email body
    Then they should see an attachment with the email
    And  the attachment should contain:
      | company_name | email         | first_name | last_name | status  |
      | Four         |               | company    | four      | invalid |
      | Five         | five@test.com | company    | five      | invited |

  @javascript
  Scenario: Company name autocomplete active with 3 or more characters
    Given the following companies:
      | name               | _type      | country       |
      | Planet of the apes | Contractor | United States |
    And the following invitations:
      | company_name | email                | first_name | last_name |
      | Planet Ice   | planet_ice@test.com  | planet     | ice       |
      | Planet Fire  | planet_fire@test.com | planet     | fire      |
    When I follow "New Invitation"
    And  I fill in "Company name" with "Pl"
    Then I should not see "Planet Express"
    And  I should not see "Planet of the apes"
    And  I should not see "Planet Ice"
    And  I should not see "Planet Fire"

  @javascript
  Scenario: Company name autocomplete should find company names that begin with search term
    Given the following companies:
      | name               | _type      | country       |
      | Planet of the apes | Contractor | United States |
      | Wicked Planet      | Supplier   | United States |
    When I follow "New Invitation"
    And  I fill in "Company name" with "Planet"
    Then I should see "Planet Express"
    And  I should see "Planet of the apes"
    Then I should not see "Wicked Planet"

  @javascript
  Scenario: Company name autocomplete limited to 5 results
    Given the following companies:
      | name               | _type      | country       |
      | Planet of the apes | Contractor | United States |
      | Planet Wicked      | Supplier   | United States |
      | Planet Hollywood   | Contractor | United States |
      | Planet Pizza       | Supplier   | United States |
      | Planet Taco        | Contractor | United States |
      | Planet Awesome     | Supplier   | United States |
    When I follow "New Invitation"
    And  I fill in "Company name" with "Planet"
    Then I should see "Planet Awesome"
    And  I should see "Planet Express"
    And  I should see "Planet Hollywood"
    And  I should see "Planet Pizza"
    And  I should see "Planet Taco"
    And  I should not see "Planet Wicked"
    And  I should not see "Planet of the apes"
