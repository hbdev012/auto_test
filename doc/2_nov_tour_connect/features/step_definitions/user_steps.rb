Given /^the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    role         = hash.delete 'role'
    confirmed    = hash.delete 'confirmed'
    pending      = hash.delete 'pending'
    company_name = hash.delete 'company_name'

    company = Company.where(:name => company_name).last
    user    = Factory.build(:user, hash)

    user.skip_confirmation = (pending == 'true')

    company.users << user

    company.has_pending_user!(user) if pending == 'true'
    user.confirm!                   if confirmed == 'true'

    if role.present?
      user.role = role
      user.save!
    end
  end
end

Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I check "Remember me"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Login"}
  And %{I should not see "Logout"}
end

Then /"(.*)" should be the creator of "(.*)" in "(.*)"/ do |email, company_name, country|
  user = User.where(:email => email).last
  company = Company.where(:name => company_name, :country => country).last

  company.creator.should == user
end

Then /"(.*)" is a pending user for "(.*)" in "(.*)"/ do |email, company_name, country|
  user = User.where(:email => email).last
  company = Company.where(:name => company_name, :country => country).last

  user.company.should == company
  company.should have_pending_user(user)
end

Then /^"([^\"]*)" should be an admin$/ do |email|
  User.where(:email => email).last.role.should == 'admin'
end

Then /^"([^\"]*)" should not be an admin$/ do |email|
  User.where(:email => email).last.role.should_not == 'admin'
end
