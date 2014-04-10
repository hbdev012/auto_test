Given /^"([^\"]*)" has the following non accommodations:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    company.properties << Factory.build(:non_accommodation, :name => hash['name'])
  end
end
