Then /^"([^\"]*)" product rates should have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name)

 table.hashes.each do | hash |
    prg = ProductRateGroup.where(:season_id => Season.where(:name => hash['season_name']).first.id).first
    prg.product_market.all_markets.should         == (hash['all_markets']      == 'true')
    prg.product_market.inbound_markets.should     == (hash['inbound_markets']  == 'true')
    prg.product_market.domestic_markets.should    == (hash['domestic_markets'] == 'true')
    prg.product_market.eta_markets.should         == (hash['eta_markets']      == 'true')
    prg.product_market.other_markets.should       == (hash['other_markets']    == 'true')
    prg.product_market.other_markets_value.should == hash['other_markets_value']
    prg.departs.should                            == hash['departs']
    prg.departure_week_days.to_s.should           == hash['departure_week_days'].to_s
    prg.include_meal.should                       == (hash['include_meal']     == 'true')
    prg.meal_details.should                       == hash['meal_details']
    prg.gst_tax_included.should                   == (hash['gst_tax_included'] == 'true')
  end
end

Then /^"([^\"]*)" product rates should not have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name)

  table.hashes.each do |hash|
    prg = ProductRateGroup.where(:season_id => Season.where(:name => hash['season_name']).first.id).should be_empty
  end
end

And /^the "([^\"]*)" product rate group "([^\"]*)" date ranges should have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    prg.departure_date_ranges.where(:begins_on => hash['from'].to_date, :ends_on => hash['to'].to_date).should_not be_empty
  end
end

And /^the "([^\"]*)" product rate group "([^\"]*)" date ranges should not have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    prg.departure_date_ranges.where(:begins_on => hash['from'].to_date, :ends_on => hash['to'].to_date).should be_empty
  end
end

And /^the "([^\"]*)" product rate group "([^\"]*)" product rates should have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    product_rate = prg.product_rates.where(:description => hash.delete('description')).first
    product_rate.price_info.price_code.should == hash.delete('price_code')
    hash.each do |k,v|
      product_rate.price_info.send(k).should == v.to_f
    end
  end
end

And /^the "([^\"]*)" product rate group "([^\"]*)" product rates should not have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    prg.product_rates.where(:description => hash['description']).should be_empty
  end
end

Then /^the "([^\"]*)" product rate group "([^\"]*)" should have the following blackout periods:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    blackout = prg.blackout_periods.where(:name => hash['name']).first

    blackout.begins_on.should == hash['begins_on'].to_date
    blackout.ends_on.should   == hash['ends_on'].to_date
  end
end

Then /^the "([^\"]*)" product rate group "([^\"]*)" should not have the following blackout periods:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  prg     = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    prg.blackout_periods.where(:name => hash['name']).should be_empty
  end
end

Then /^the "([^"]*)" product rate group "([^"]*)" special pricing periods should have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  product_rate_group = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    special_pricing_period = product_rate_group.special_pricing_periods.where(:name => hash.delete('name')).first
    special_pricing_period.price_info.price_code.to_s.should      == hash['price_code']
    special_pricing_period.price_info.adult_rate.to_s.should      == hash['adult_rate']
    special_pricing_period.price_info.child_rate.to_s.should      == hash['child_rate']
    special_pricing_period.price_info.infant_rate.to_s.should     == hash['infant_rate']
    special_pricing_period.price_info.student_rate.to_s.should    == hash['student_rate']
    special_pricing_period.price_info.concession_rate.to_s.should == hash['concession_rate']
  end

end

Then /^the "([^"]*)" product rate group "([^"]*)" special pricing periods should not have the following values:$/ do |product_name, season_name, table|
  product = Product.where(:name => product_name).first
  product_rate_group = product.product_rate_groups.where(:season_id => Season.where(:name => season_name).first.id).first

  table.hashes.each do |hash|
    product_rate_group.special_pricing_periods.where(:name => hash['name']).should be_empty
  end

end
