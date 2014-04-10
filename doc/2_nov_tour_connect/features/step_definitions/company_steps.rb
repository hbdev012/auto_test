Given /^the following companies:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    company = case type = hash.delete('_type')
      when 'Supplier'
        Factory.create :supplier, hash
      when 'Contractor'
        Factory.create :contractor, hash
      else
        raise "Unknown Company type: #{type}"
    end

    # Also initialize the creator
    user = Factory.create(:user)
    user.has_role!(:admin)
    company.users << user
    company.assign_creator!(user)
  end
end

Given /"([^\"]*)" has valid billing information$/ do |company_name|
  company = Company.where(:name => company_name).first
  company.build_billing_information(Factory.attributes_for(:billing_information).merge(:account_name => 'Checking Account'))
  company.save!
end

Then /"([^\"]*)" in "([^\"]*)" should be a (.*)/ do |name, country, type|
  type.classify.constantize.where(:name => name, :country => country).last.should be_present
end

Then /^the company name field should be replaced with the selected company "(.*)\/(.*)"$/ do |name, country|
  page.should have_css("div#company-form", :visible => false)
  page.find("div#selected-company") do |div|
    div.should have_content name
    div.should have_content country
  end
end

Then /^the selected company "(.*)\/(.*)" should be replaced with the company name field$/ do |name, country|
  page.should have_css("div#company-form")
  page.should have_no_css("div#selected-company")
end

Then /^"([^\"]*)" corporate information should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first
  corporate_information = company.corporate_information

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    corporate_information.send(name).should == value
  end
end

When /^"([^\"]*)" should have a logo named "([^\"]*)"$/ do |company_name, filename|
  company = Company.where(:name => company_name).first
  corporate_information = company.corporate_information

  corporate_information.logo.size.should > 0
  corporate_information.logo.name.should == filename
end
