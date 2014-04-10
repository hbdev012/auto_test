Given /^"([^"]*)" has the following products:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.hashes.each do |hash|
    property.products.create! hash.merge(:supplier_id => property.supplier.id)
  end
end

Then /^"([^\"]*)" products should have the following values:$/ do | property_name, table |
  property = Property.where(:name => property_name).first

 table.hashes.each do | hash |
    product = property.products.where(:name => hash['name']).first

    product.code.should                == hash['code']
    product.duration_value.should      == hash['duration_value'].to_i
    product.duration_units.should      == hash['duration_units']
    product.short_description.should   == hash['short_description']
    product.details.should             == hash['details']
    product.minimum_pax_adult.should   == hash['minimum_pax_adult'].to_i
    product.minimum_pax_child.should   == hash['minimum_pax_child'].to_i
    product.minimum_pax_total.should   == hash['minimum_pax_total'].to_i
    product.maximum_pax_adult.should   == hash['maximum_pax_adult'].to_i
    product.maximum_pax_child.should   == hash['maximum_pax_child'].to_i
    product.maximum_pax_total.should   == hash['maximum_pax_total'].to_i
    product.pick_up_departs_at.should  == Time.parse(hash['pick_up_departs_at'])
    product.pick_up_location.should    == hash['pick_up_location']
    product.drop_off_departs_at.should == Time.parse(hash['drop_off_departs_at'])
    product.drop_off_location.should   == hash['drop_off_location']
    product.standard_inclusion.should  == hash['standard_inclusion']
    product.what_to_bring.should       == hash['what_to_bring']
  end
end

Then /^the "([^"]*)" should have the following inherited bonus offers:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    product.inherited_bonus_offers.should include(BonusOffer.where(:title => hash['title']).first.id)
  end
end

Then /^the "([^"]*)" should not have the following inherited bonus offers:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    product.inherited_bonus_offers.should_not include(BonusOffer.where(:title => hash['title']).first.id)
  end
end

Then /^the "([^\"]*)" product bonus offers should have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    bonus_offer = product.bonus_offers.where(:booking_code => hash['booking_code']).first

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

Then /^the "([^\"]*)" product bonus offers should not have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    bonus_offer = product.bonus_offers.where(:booking_code => hash['booking_code']).first
    bonus_offer.should be_nil
  end
end

Then /^the "([^\"]*)" product bonus offer "([^\"]*)" date ranges should have the following values:$/ do |product_name, booking_code, table|
  product     = Product.where(:name => product_name).first
  bonus_offer = product.bonus_offers.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    date_range = bonus_offer.bonus_offer_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    date_range.should_not be_nil
  end
end

Then /^the "([^\"]*)" product bonus offer "([^\"]*)" date ranges should not have the following values:$/ do |product_name, booking_code, table|
  product     = Product.where(:name => product_name).first
  bonus_offer = product.bonus_offers.where(:booking_code => booking_code).first

  table.hashes.each do |hash|
    date_range = bonus_offer.bonus_offer_date_ranges.where(:from => hash['from'], :to => hash['to']).first
    date_range.should be_nil
  end
end

Then /^"([^\"]*)" product images should have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    image = product.images.where(:attachment_name => hash['attachment_name']).first
    image.attachment.size.should > 0
  end
end

Then /^"([^\"]*)" product images should not have the following values:$/ do |product_name, table|
  product = Product.where(:name => product_name).first

  table.hashes.each do |hash|
    product.images.where(:attachment_name => hash['attachment_name']).should be_empty
  end
end

