When /^"([^\"]*)" has the following amenities:$/ do |company_name, table|
  company = Supplier.where(:name => company_name).first

  table.hashes.each do |hash|
    company.amenities << hash['name']
  end

  company.save!
end

Then /^"([^\"]*)" supplier corporate information should have the following values:$/ do |company_name, table|
  company = Supplier.where(:name => company_name).first
  supplier_corporate_information = company.supplier_corporate_information

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    supplier_corporate_information.send(name).should == value
  end
end
