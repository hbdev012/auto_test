Then /^"([^\"]*)" property policy should have the following values:$/ do |property_name, table|
  property = Property.where(:name => property_name).first

  table.rows_hash.each do |name, value|
    value = value.to_i.to_s == value ? value.to_i : (value.to_f.to_s == value ? value.to_f : value)
    property.property_policy.send(name).should == value
  end
end
