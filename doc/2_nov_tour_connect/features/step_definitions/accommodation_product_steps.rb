Then /^"([^\"]*)" accommodation products should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

 table.hashes.each do |hash|
    accommodation_product = property.products.where(:name => hash['name']).first

    accommodation_product.code.should                       == hash['code']
    accommodation_product.allocation_type.should            == hash['allocation_type']
    accommodation_product.number_of_rooms.to_i.should       == hash['number_of_rooms'].to_i
    accommodation_product.releaseback_days.to_i.should      == hash['releaseback_days'].to_i
    accommodation_product.short_description.should          == hash['short_description']
    accommodation_product.details.should                    == hash['details']
    accommodation_product.general_notes.should              == hash['general_notes']
    accommodation_product.complies_to_eu_regulations.should == (hash['complies_to_eu_regulations'] == 'true')
  end
end

Then /^"([^\"]*)" room detail should have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    details = product.room_detail

    details.check_in_at.should                  == Time.parse(hash['check_in_at'])                  if hash['check_in_at'].present?
    details.check_out_at.should                 == Time.parse(hash['check_out_at'])                 if hash['check_out_at'].present?
    details.late_check_out.should               == (hash['late_check_out'] == 'true')               if hash['late_check_out'].present?
    details.late_check_out_at.should            == (hash['late_check_out_at'].present? ? Time.parse(hash['late_check_out_at']) : nil)
    details.late_check_out_cost.should          == (hash['late_check_out_cost'].present? ? hash['late_check_out_cost'] : nil)
    details.room_classification.should          == hash['room_classification']                      if hash['room_classification'].present?
    details.maximum_pax_adults.should           == hash['maximum_pax_adults'].to_i                  if hash['maximum_pax_adults'].present?
    details.maximum_pax_adult_child.should      == hash['maximum_pax_adult_child']                  if hash['maximum_pax_adult_child'].present?
    details.existing_bedding.should             == hash['existing_bedding']                         if hash['existing_bedding'].present?
    details.sofas.should                        == hash['sofas'].to_i                               if hash['sofas'].present?
    details.rollaways.should                    == hash['rollaways'].to_i                           if hash['rollaways'].present?
    details.consider_as_existing_bedding.should == (hash['consider_as_existing_bedding'] == 'true') if hash['consider_as_existing_bedding'].present?
    details.interconnecting_rooms.should        == (hash['interconnecting_rooms'] == 'true')        if hash['interconnecting_rooms'].present?
  end
end

Then /^"([^\"]*)" room rates should have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    room_rate = product.room_rates.where(:season_id => Season.where(:name => hash['season_name']).first.id).first

    room_rate.rate_type.should == hash['rate_type'] if hash['rate_type'].present?
    room_rate.inclusion.should == hash['inclusion'] if hash['inclusion'].present?

    room_rate.product_market.all_markets.should         == (hash['all_markets'] == 'true')      if hash['all_markets'].present?
    room_rate.product_market.inbound_markets.should     == (hash['inbound_markets'] == 'true')  if hash['inbound_markets'].present?
    room_rate.product_market.domestic_markets.should    == (hash['domestic_markets'] == 'true') if hash['domestic_markets'].present?
    room_rate.product_market.eta_markets.should         == (hash['eta_markets'] == 'true')      if hash['eta_markets'].present?
    room_rate.product_market.other_markets.should       == (hash['other_markets'] == 'true')    if hash['other_markets'].present?
    room_rate.product_market.other_markets_value.should == hash['other_markets_value']          if hash['other_markets_value'].present?

    room_rate.weekend_same_as_other_days.should == (hash['weekend_same_as_other_days'] == 'true') if hash['weekend_same_as_other_days'].present?
    room_rate.weekend_days.should               == hash['weekend_days']                           if hash['weekend_days'].present?
    room_rate.weekend_minimum_nights.should     == hash['weekend_minimum_nights'].to_i            if hash['weekend_minimum_nights'].present?
  end
end

Then /^"([^\"]*)" room rates should not have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    product.room_rates.where(:season_id => Season.where(:name => hash['season_name']).first.id).should be_empty
  end
end

Given /^"([^"]*)" has the following amenities: "([^"]*)"$/ do |accommodation_name, amenities|
  accommodation = Accommodation.where(:name => accommodation_name).first
  accommodation.amenities << amenities.split(', ')
end

Then /^"([^"]*)" amenities should have the following values: "([^"]*)"$/ do |accommodation_name, amenities|
  accommodation = Accommodation.where(:name => accommodation_name).first
  accommodation.amenities.should == amenities.split(', ')
end

Then /^"([^"]*)" accommodation product room detail amenities should have the following values:$/ do |accommodation_product_name, table|
  room_detail = AccommodationProduct.where(:name => accommodation_product_name).first.room_detail

  table.hashes.each do |hash|
    room_detail.amenities.should include(hash['name'])
  end
end

Then /^"([^"]*)" accommodation product room detail amenities should not have the following values:$/ do |accommodation_product_name, table|
  room_detail = AccommodationProduct.where(:name => accommodation_product_name).first.room_detail

  table.hashes.each do |hash|
    room_detail.amenities.should_not include(hash['name'])
  end
end

Then /^"([^\"]*)" room rate "([^\"]*)" validity dates should have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.validity_dates.where(:begins_on => hash['from'].to_date, :ends_on => hash['to'].to_date).should_not be_empty
  end
end

Then /^"([^\"]*)" room rate "([^\"]*)" validity dates should not have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.validity_dates.where(:begins_on => hash['from'].to_date, :ends_on => hash['to'].to_date).should be_empty
  end
end

Then /^"([^\"]*)" room rate "([^\"]*)" product rates should have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    product_rate = room_rate.product_rates.where(:description => hash.delete('description')).first
    product_rate.price_info.price_code.should == hash.delete('price_code')

    hash.each do |k,v|
      product_rate.price_info.send(k).should == v.to_f
    end
  end
end

Then /^"([^\"]*)" room rate "([^\"]*)" product rates should not have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.product_rates.where(:description => hash['description']).should be_empty
  end
end

Then /^"([^"]*)" room rate "([^"]*)" weekend rates should have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    weekend_rate = room_rate.weekend_rates.where(:description => hash.delete('description')).first
    weekend_rate.price_info.price_code.should == hash.delete('price_code')

    hash.each do |k,v|
      weekend_rate.price_info.send(k).should == v.to_f
    end
  end
end

Then /^"([^"]*)" room rate "([^"]*)" weekend rates should not have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.weekend_rates.where(:description => hash['description']).should be_empty
  end
end

Then /^"([^"]*)" room rate "([^"]*)" stay pay offers should have the following values:$/ do |product_name, season_name, table|
  product      = Product.where(:name => product_name).first
  room_rate    = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    stay_pay_offer = room_rate.stay_pay_offers.where(:name => hash.delete('name')).first

    hash.each do |k,v|
      stay_pay_offer.send(k).to_s.should == v
    end
  end
end

Then /^"([^"]*)" room rate "([^"]*)" stay pay offers should not have the following values:$/ do |product_name, season_name, table|
  product      = Product.where(:name => product_name).first
  room_rate    = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.stay_pay_offers.where(:name => hash['name']).should be_empty
  end
end

Then /^"([^"]*)" room rates "([^"]*)" should have stay pay offers available$/ do |product_name, season_name|
  product      = Product.where(:name => product_name).first
  room_rate    = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first
  room_rate.stay_pay_available.should == true
end

Then /^"([^"]*)" room rate "([^"]*)" meal rates should have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    meal_rate = room_rate.meal_rates.where(:name => hash.delete('name')).first

    hash.each do |k,v|
      meal_rate.send(k).to_s.should == v
    end
  end

end

Then /^"([^"]*)" room rate "([^"]*)" meal rates should not have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.meal_rates.where(:name => hash['name']).should be_empty
  end

end


Then /^"([^"]*)" room rate "([^"]*)" special event meals should have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    special_event_meal = room_rate.special_event_meals.where(:name => hash.delete('name')).first

    hash.each do |k,v|
      special_event_meal.send(k).to_s.should == v
    end
  end

end

Then /^"([^"]*)" room rate "([^"]*)" special event meals should not have the following values:$/ do |product_name, season_name, table|
  product   = Product.where(:name => product_name).first
  room_rate = product.room_rates.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    room_rate.special_event_meals.where(:name => hash['name']).should be_empty
  end
end

