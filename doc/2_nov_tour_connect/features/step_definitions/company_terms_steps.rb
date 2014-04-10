Then /^"([^\"]*)" terms and conditions should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first
  terms   = company.supplier_term

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    terms.send(name).should == value
  end
end
