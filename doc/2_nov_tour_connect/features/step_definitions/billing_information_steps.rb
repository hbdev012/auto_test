Given /^"([^\"]*)" has valid corporate information$/ do |company_name|
  company = Company.where(:name => company_name).last

  company.update_attributes(:product_type         => 'Accommodation',
                            :direct_products      => 'true',
                            :description          => 'This is the best company ever',
                            :address_1            => '123 Main St.',
                            :address_2            => 'Suite 101',
                            :city                 => 'Somewhere',
                            :state                => 'CA',
                            :postal_code          => '90210',
                            :country              => 'United States',
                            :corporate_identifier => '123456AB',
                            :uri                  => 'http://test.com/',
                            :fax_number           => '602-123-4567',
                            :phone_number         => '602-123-4568')
end

Then /^"([^\"]*)" billing information should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first
  billing_information = company.billing_information

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    billing_information.send(name).should == value
  end
end
