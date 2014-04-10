Given /^"([^\"]*)" has the following accommodations:$/ do |company_name, table|
  company = Company.where(:name => company_name).first

  table.hashes.each do |hash|
    company.properties << Factory.build(:accommodation, :name => hash['name'])
  end
end

Then /^"([^\"]*)" accommodation classifications should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    accommodation.classifications.should include(hash['name'])
  end
end

Then /^"([^\"]*)" accommodation classifications should not have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    accommodation.classifications.should_not include(hash['name'])
  end
end

Then /^"([^\"]*)" accommodation ratings should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.rows_hash.each do |name, value|
    value = value.to_i.to_s == value ? value.to_i : value
    accommodation.send(name).should == value
  end
end

Then /^"([^\"]*)" accommodation amenities should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    accommodation.amenities.should include(hash['name'])
  end
end

Then /^"([^\"]*)" accommodation amenities should not have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    accommodation.amenities.should_not include(hash['name'])
  end
end

Then /^"([^\"]*)" transfer should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.rows_hash.each do |name, value|
    value = value.to_i.to_s == value ? value.to_i : value
    value = value.to_f.to_s == value ? value.to_f : value
    value = true  if value == "true"
    value = false if value == "false"

    accommodation.transfer.send(name).should == value
  end
end

Then /^I should see the correct currency symbol for "([^\"]*)"$/ do |property_name|
  page.should have_css 'span.type-currency', :text => '$'
end

Then /^I should not see the correct currency symbol for "([^\"]*)"$/ do |property_name|
  page.should have_no_css 'span.type-currency', :text => '$'
end

Then /^I should see the percent symbol$/ do
  page.should have_css 'span.type-percent', :text => '%'
end

Then /^I should not see the percent symbol$/ do
  page.should have_no_css 'span.type-percent', :text => '%'
end

## Stay/Pay Deals

Then /^the "([^\"]*)" stay pay deals should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    stay_pay_deal = accommodation.stay_pay_deals.where(:booking_code => hash['booking_code']).first

    stay_pay_deal.partial_offers.should      == (hash['partial_offers']      == 'true')
    stay_pay_deal.standard_meal_offer.should == (hash['standard_meal_offer'] == 'true')
    stay_pay_deal.special_conditions.should  == hash['special_conditions']
    stay_pay_deal.special_conditions.should  == hash['special_conditions']
    stay_pay_deal.combinable_allowed.should  == (hash['combinable_allowed'] == 'true')
    stay_pay_deal.combined_offer.should      == hash['combined_offer']
  end
end

Then /^the "([^\"]*)" stay pay deal "([^\"]*)" stay pay offers should have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  stay_pay_deal  = accommodation.stay_pay_deals.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    stay_pay_offer = stay_pay_deal.stay_pay_offers.where(:name => hash['name']).first
    stay_pay_offer.stay.should              == hash['stay'].to_i
    stay_pay_offer.pay.should               == hash['pay'].to_i
    stay_pay_offer.apply_for_weekend.should == (hash['apply_for_weekend'] == 'true')
  end
end

Then /^the "([^\"]*)" stay pay deal "([^\"]*)" stay pay offers date ranges should have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation = Accommodation.where(:name => accommodation_name).first
  stay_pay_deal = accommodation.stay_pay_deals.where(:booking_code => booking_code).first
  table.hashes.each do |hash|
    spd = stay_pay_deal.stay_pay_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    spd.should_not be_nil
  end

end

Then /^the "([^\"]*)" stay pay deal "([^\"]*)" stay pay offers date ranges should not have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  stay_pay_deal  = accommodation.stay_pay_deals.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    deal = stay_pay_deal.stay_pay_date_ranges.where(:from => hash['from'], :to => hash['to']).first

    deal.should be_nil
  end

end

Then /^the "([^\"]*)" stay pay deal "([^\"]*)" stay pay offers should not have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  stay_pay_deal  = accommodation.stay_pay_deals.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    stay_pay_offer = stay_pay_deal.stay_pay_offers.where(:name => hash['name'],
                                                         :stay => hash['stay'],
                                                         :pay  => hash['pay']).first

    stay_pay_offer.should be_nil
  end
end

Then /^the "([^\"]*)" stay pay deals should not have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    stay_pay_deal = accommodation.stay_pay_deals.where(:booking_code => hash['booking_code']).first

    stay_pay_deal.should be_nil
  end
end

# Room Upgrades ==================================================

Then /^the "([^\"]*)" room upgrades should have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    room_upgrade = accommodation.room_upgrades.where(:booking_code => hash['booking_code']).first

    room_upgrade.special_conditions.should  == hash['special_conditions']
    room_upgrade.combinable_allowed.should  == (hash['combinable_allowed'] == 'true')
    room_upgrade.combined_offer.should      == hash['combined_offer']
  end
end

Then /^the "([^\"]*)" room upgrade "([^\"]*)" room upgrade offers should have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  room_upgrade = accommodation.room_upgrades.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    room_upgrade_offer = room_upgrade.room_upgrade_offers.where(:from_room_type => hash['from_room_type'], :to_room_type => hash['to_room_type']).first

    room_upgrade_offer.should be_present
  end
end

Then /^the "([^\"]*)" room upgrade "([^\"]*)" room upgrade offers date ranges should have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation = Accommodation.where(:name => accommodation_name).first
  room_upgrade = accommodation.room_upgrades.where(:booking_code => booking_code).first
  table.hashes.each do |hash|
    ru = room_upgrade.room_upgrade_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    ru.should_not be_nil
  end
end

Then /^the "([^\"]*)" room upgrade "([^\"]*)" room upgrade offers date ranges should not have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  room_upgrade  = accommodation.room_upgrades.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    ru = room_upgrade.room_upgrade_date_ranges.where(:from => hash['from'], :to => hash['to']).first

    ru.should be_nil
  end

end

Then /^the "([^\"]*)" room upgrades should not have the following values:$/ do |accommodation_name, table|
  accommodation = Accommodation.where(:name => accommodation_name).first

  table.hashes.each do |hash|
    room_upgrade = accommodation.room_upgrades.where(:booking_code => hash['booking_code']).first

    room_upgrade.should be_nil
  end
end

Then /^the "([^\"]*)" room upgrade "([^\"]*)" room upgrade offers should not have the following values:$/ do |accommodation_name, booking_code, table|
  accommodation  = Accommodation.where(:name => accommodation_name).first
  room_upgrade = accommodation.room_upgrades.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    room_upgrade_offer = room_upgrade.room_upgrade_offers.where(:from_room_type => hash['from_room_type'], :to_room_type => hash['to_room_type']).first

    room_upgrade_offer.should_not be_present
  end
end

Then /^"([^\"]*)" should be set to (\d+)$/ do |field, num|
  find("##{field}").value.should == num
end

