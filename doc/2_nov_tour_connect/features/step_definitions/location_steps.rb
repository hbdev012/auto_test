Then /^"([^\"]*)" location should have the following values:$/ do |company_name, table|
  company  = Company.where(:name => company_name).first
  location = company.corporate_locations.first

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    location.send(name).should == value
  end
end
