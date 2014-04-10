Then /^"([^\"]*)" contractor terms should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    contractor_terms = company.contractor_terms.where(:title => hash['title']).first

    contractor_terms.submission_criteria.should == hash['submission_criteria']
    contractor_terms.terms.should               == hash['terms']
  end
end

Then /^"([^\"]*)" contractor terms should not have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    company.contractor_terms.where(:title => hash['title']).should be_empty
  end
end
