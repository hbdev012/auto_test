When /^I add the (.*) contact group$/ do |contact_group_name|
  click_link "Add another contact group"
  within("#contact-groups .fields:nth-last-child(2)") do
    fill_in "Name", :with => contact_group_name.humanize
    # find('a', :text => "Add another person in the same contact group").click
    trigger_change('.contact-group-name')
  end
end

When /^I remove the (.*) contact group$/ do |contact_group_name|
  within("##{contact_group_name}-contact-group") do
    click_link "Remove contact group"
  end
end

Then /^I should see an? (.*) default contact group$/ do |contact_group_name|
  within("##{contact_group_name}-contact-group") do
    Then %(I should see "#{contact_group_name.humanize} Contact")
    And  %(I should not see "Remove contact group")
  end

  within("##{contact_group_name}-contact-group .contacts .fields:first-child") do
    lambda { find('a', :text => 'x') }.should raise_exception(Capybara::ElementNotFound)
  end
end

When /^"([^\"]*)" contact groups should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    company.contact_groups.where(hash).should be_present
  end
end

When /^"([^\"]*)" contact groups should not have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    company.contact_groups.where(hash).should be_empty
  end
end
