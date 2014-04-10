# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts
puts 'SETTING UP DEFAULT SUPPLIER'
supplier = Supplier.create! :name => 'Planet Express', :country => 'United States'
admin    = supplier.users.build({
  :first_name            => 'Supplier',
  :last_name             => 'User',
  :email                 => 'supplier@test.com',
  :password              => 'password',
  :password_confirmation => 'password',
  :terms                 => '1',
  :job_title             => 'CEO'
})

admin.confirm!
admin.has_role!(:admin)
supplier.assign_creator!(admin)

user = supplier.users.build({
  :first_name            => 'Pending',
  :last_name             => 'Supplier',
  :email                 => 'pending.supplier@test.com',
  :password              => 'password',
  :password_confirmation => 'password',
  :terms                 => '1',
  :job_title             => 'Accountant'
})

user.skip_confirmation = true
user.save!
supplier.has_pending_user!(user)

puts "Company created: #{supplier.name}"
puts "Admin user created: #{admin.name} (#{admin.email})"
puts "Pending user created: #{user.name} (#{user.email})"


puts
puts 'SETTING UP DEFAULT CONTRACTOR'
contractor = Contractor.create!(:name => 'Planet Express', :country => 'United States')
admin      = contractor.users.build({
  :first_name            => 'Contractor',
  :last_name             => 'User',
  :email                 => 'contractor@test.com',
  :password              => 'password',
  :password_confirmation => 'password',
  :terms                 => '1',
  :job_title             => 'CEO'
})

admin.confirm!
admin.has_role!(:admin)
contractor.assign_creator!(admin)

user = contractor.users.build({
  :first_name            => 'Pending',
  :last_name             => 'Contractor',
  :email                 => 'pending.contractor@test.com',
  :password              => 'password',
  :password_confirmation => 'password',
  :terms                 => '1',
  :job_title             => 'Accountant'
})

user.skip_confirmation = true
user.save!
contractor.has_pending_user!(user)

puts "Company created: #{contractor.name}"
puts "Admin user created: #{admin.name} (#{admin.email})"
puts "Pending user created: #{user.name} (#{user.email})"

puts
puts 'SETTING UP DEFAULT NON ACCOMMODATION'

non_accommodation = NonAccommodation.create!({
  :name              => 'Non-Accommodation Test Property',
  :long_description  => 'Non-Accommodation Test Property 1',
  :short_description => 'Non',
  :supplier          => supplier
})

non_accommodation.seasons.create!({ :name => 'Full Year', :begins_on => Time.zone.now.at_beginning_of_year, :ends_on => Time.zone.now.at_end_of_year })

puts "Non-Accommodation created: #{non_accommodation.name}"
puts " - Seasons created:"
non_accommodation.seasons.each do |season|
  puts "    * #{season.name}"
end

puts
puts 'SETTING UP DEFAULT ACCOMMODATION'

accommodation = Accommodation.create!({
  :name              => 'Accommodation Test Property',
  :long_description  => 'Accommodation Test Property 1',
  :short_description => 'Acco',
  :supplier          => supplier
})

accommodation.seasons.create!({ :name => 'Full Year', :begins_on => Time.zone.now.at_beginning_of_year, :ends_on => Time.zone.now.at_end_of_year })

puts "Accommodation created: #{accommodation.name}"
puts " - Seasons created:"
accommodation.seasons.each do |season|
  puts "    * #{season.name}"
end
