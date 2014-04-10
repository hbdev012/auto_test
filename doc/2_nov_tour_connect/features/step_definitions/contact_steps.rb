When /^I fill in the administrator contact information$/ do
  within("#administrator-contact-group") do
    fill_in "Phone number", :with => '602-123-4567'
    fill_in "Fax number",   :with => '602-123-4568'
  end
end

When /^I fill in the (.*) contact$/ do |contact_group_name|
  within("##{contact_group_name}-contact-group") do
    fill_in_contact contact_group_name
  end
end

When /^I fill in another (.*) contact$/ do |contact_group_name|
  within("##{contact_group_name}-contact-group") do
    click_link 'Add another person in the same contact group'
  end

  within("##{contact_group_name}-contact-group .contacts .fields:nth-last-child(2)") do
    fill_in_contact contact_group_name, 1
  end
end

When /^I remove the last (.*) contact$/ do |contact_group_name|
  within("##{contact_group_name}-contact-group .contacts .fields:nth-last-child(2)") do
    find('a', :text => 'x').click
  end
end

def fill_in_contact contact_group_name, count=nil
  fill_in "First name",   :with => "#{contact_group_name.humanize}#{count}"
  fill_in "Last name",    :with => 'Contact'
  fill_in "Phone number", :with => '602-123-4567'
  fill_in "Fax number",   :with => '602-123-4568'
  fill_in "Email",        :with => "#{contact_group_name}#{count}@test.com"
end

When /^"([^\"]*)" contacts should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first
  table.hashes.each do |hash|
    contact_group = company.contact_groups.where(:name => hash.delete('contact_group')).first
    contact_group.contacts.where(hash).should be_present
  end
end
