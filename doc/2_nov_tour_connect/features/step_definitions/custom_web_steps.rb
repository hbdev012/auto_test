When /^I click the link with text "([^\"]*)"$/ do |text|
  find('a', :text => text).click
end

When /^(?:|I )select "([^"]+)" as the "([^"]+)" time$/ do |time, selector|
  select_time(selector, :with => time)
end

When /^(?:|I )select "([^"]+)" as the "([^"]+)" date$/ do |date, selector|
  select_date(selector, :with => date)
end

When /^(?:|I )select "([^"]+)" as the "([^"]+)" date and time$/ do |datetime, selector|
  select_datetime(selector, :with => datetime)
end

When /^it is the year (\d+)$/ do |year|
  Delorean.time_travel_to "#{year}-01-01"
end

When /^I check the following fields:$/ do |table|
  table.rows_hash.each do |name, value|
    check(name) if value == 'true'
  end
end

Then /^I should not see the "([^"]*)" field$/ do |field|
  find_field(field).should_not be_visible
end

Then /^I should see the "([^"]*)" field$/ do |field|
  find_field(field).should be_visible
end

Then /^"([^\"]*)" should be visible$/ do |locator|
  page.should have_css(locator, :visible => true)
end

Then /^"([^\"]*)" should not be visible$/ do |locator|
  page.should have_css(locator, :visible => false)
end

Then /^the "([^"]*)" link should have confirmation$/ do |text|
  find('a', :text => text)['data-confirm'].should be_present
end
