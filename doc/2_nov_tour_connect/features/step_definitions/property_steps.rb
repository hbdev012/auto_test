Given /^the "([^"]*)" property "([^"]*)" season has the following blackout periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    season.blackout_periods.create! hash
  end
end

Given /^the "([^"]*)" property "([^"]*)" season has the following special pricing periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    season.special_pricing_periods.create! hash
  end
end

Then /^"([^\"]*)" properties should have the following values:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    property = company.properties.where(:name => hash['name']).first

    property.short_description.should == hash['short_description']
    property.long_description.should  == hash['long_description']

    property.conforms_to_eu.should    == (hash['conforms_to_eu'] == 'true')
  end
end

Then /^"([^\"]*)" property location should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first
  location = property.property_locations.first

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    location.send(name).should == value
  end
end

Then /^"([^\"]*)" property billing information should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first
  billing_information = property.billing_information

  table.rows_hash.each do |name, value|
    value = true  if value == "true"
    value = false if value == "false"

    billing_information.send(name).should == value
  end
end

Then /^"([^\"]*)" property billing information should be the same as corporate$/ do |property_name|
  property = Property.where(:name => property_name).first

  property.billing_information.should == property.supplier.billing_information
end

Then /^"([^\"]*)" property terms should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first
  supplier_terms = property.supplier_term

  table.hashes.each do |hash|
    supplier_terms.terms.should == hash['terms']
  end
end

Then /^"([^\"]*)" property terms should be the same as corporate$/ do |property_name|
  property = Property.where(:name => property_name).first

  property.supplier_term.should == property.supplier.supplier_term
end

Then /^"([^\"]*)" property contact groups should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.contact_groups.where(hash).should be_present
  end
end

Then /^"([^\"]*)" property contact groups should not have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.contact_groups.where(hash).should be_empty
  end
end

Then /^"([^\"]*)" property contacts should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    contact_group = property.contact_groups.where(:name => hash.delete('contact_group')).first

    contact_group.contacts.where(hash).should be_present
  end
end

Then /^"([^\"]*)" property insurance information should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    ins_info = property.insurance_information
    
    ins_info.expires_on.should == hash['expires_on'].to_date
    ins_info.name.should       == hash['name']
  end
end

Then /^"([^\"]*)" property insurance documents should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  ins_info = property.insurance_information

  table.hashes.each do |hash|
    ins_doc = ins_info.insurance_documents.where(:attachment_name => hash['attachment_name']).first
    ins_doc.attachment.size.should > 0
  end
end

Then /^"([^\"]*)" property insurance information should be the same as corporate$/ do |property_name|
  property = Property.where(:name => property_name).first

  property.insurance_information.should == property.supplier.insurance_information
end

## Bonus Offers ##

Then /^the "([^\"]*)" bonus offers should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    bonus_offer = property.bonus_offers.where(:booking_code => hash['booking_code']).first

    hash.each do |key, value|
      value = value.to_i.to_s == value ? value.to_i : value
      value = value.to_f.to_s == value ? value.to_f : value
      value = true  if value == "true"
      value = false if value == "false"
      value = nil   if value == ""

      bonus_offer.send(key).should == value
    end
  end
end

Then /^the "([^\"]*)" bonus offers should not have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    bonus_offer = property.bonus_offers.where(:booking_code => hash['booking_code']).first
    bonus_offer.should be_nil
  end
end

Then /^the "([^\"]*)" bonus offer "([^\"]*)" date ranges should have the following values:$/ do |property_name, booking_code, table|
  property = Property.where(:name => property_name).first
  bonus_offer   = property.bonus_offers.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    date_range = bonus_offer.bonus_offer_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    date_range.should_not be_nil
  end
end

Then /^the "([^\"]*)" bonus offer "([^\"]*)" date ranges should not have the following values:$/ do |property_name, booking_code, table|
  property  = Property.where(:name => property_name).first
  bonus_offer  = property.bonus_offers.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    date_range = bonus_offer.bonus_offer_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    date_range.should be_nil
  end
end

## Images ##

Then /^"([^\"]*)" property images should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    image = property.images.where(:attachment_name => hash['attachment_name']).first
    image.attachment.size.should > 0
  end
end

Then /^"([^\"]*)" property images should not have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.images.where(:attachment_name => hash['attachment_name']).should be_empty
  end
end

Then /^the "([^\"]*)" seasons should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    season = property.seasons.where(:name => hash['name']).first

    season.begins_on.should == hash['begins_on'].to_date
    season.ends_on.should   == hash['ends_on'].to_date
  end
end

Then /^the "([^\"]*)" seasons should not have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.seasons.where(:name => hash['name']).should be_empty
  end
end

Then /^the "([^\"]*)" season "([^\"]*)" should have the following blackout periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    blackout = season.blackout_periods.where(:name => hash['name']).first

    blackout.begins_on.should == hash['begins_on'].to_date
    blackout.ends_on.should   == hash['ends_on'].to_date
  end
end

Then /^the "([^\"]*)" season "([^\"]*)" should not have the following blackout periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    season.blackout_periods.where(:name => hash['name']).should be_empty
  end
end

Then /^the "([^\"]*)" season "([^\"]*)" should have the following special pricing periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    special_pricing = season.special_pricing_periods.where(:name => hash['name']).first

    special_pricing.begins_on.should == hash['begins_on'].to_date
    special_pricing.ends_on.should   == hash['ends_on'].to_date
  end
end

Then /^the "([^\"]*)" season "([^\"]*)" should not have the following special pricing periods:$/ do |property_name, season_name, table|
  property = Property.where(:name => property_name).first
  season   = property.seasons.where(:name => season_name).first

  table.hashes.each do |hash|
    season.special_pricing_periods.where(:name => hash['name']).should be_empty
  end
end

When /^"([^\"]*)" has the following seasons:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.seasons.create!(hash)
  end
end

Given /^the "([^"]*)" property has the following bonus offers:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.bonus_offers.create!(hash)
  end
end
