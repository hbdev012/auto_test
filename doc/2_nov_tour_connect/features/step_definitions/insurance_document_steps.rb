Then /^"([^\"]*)" insurance information should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    ins_info = company.insurance_information
    
    ins_info.expires_on.should == hash['expires_on'].to_date
    ins_info.name.should       == hash['name']
  end
end

Then /^"([^\"]*)" insurance documents should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  ins_info = company.insurance_information

  table.hashes.each do |hash|
    ins_doc = ins_info.insurance_documents.where(:attachment_name => hash['attachment_name']).first
    ins_doc.attachment.size.should > 0
  end
end
