require 'factory_girl'

FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   'please'
    terms      '1'
    job_title  'Delivery Boy'
  end

  factory :company do
    name    { Faker::Company.name }
    country 'United States'
  end

  factory :supplier do
    name    { Faker::Company.name }
    country 'United States'
  end

  factory :contractor do
    name    { Faker::Company.name }
    country 'Australia'
  end

  factory :billing_information do
  end

  factory :corporate_information do
    description { Faker::Lorem.paragraph }
  end

  factory :supplier_corporate_information do
    product_type    'Accommodation'
    direct_products true
  end

  factory :location do
    address_1            { Faker::Address.street_address }
    city                 { Faker::Address.city }
    state                { Faker::Address.us_state }
    postal_code          { Faker::Address.zip_code }
    country              'United States'
    fax_number           { Faker::PhoneNumber.phone_number }
    phone_number         { Faker::PhoneNumber.phone_number }
  end

  factory :corporate_location do
    address_1            { Faker::Address.street_address }
    city                 { Faker::Address.city }
    state                { Faker::Address.us_state }
    postal_code          { Faker::Address.zip_code }
    country              'United States'
    fax_number           { Faker::PhoneNumber.phone_number }
    phone_number         { Faker::PhoneNumber.phone_number }
    corporate_identifier { Faker::Internet.ip_v4_address }
  end

  factory :property_location do
    address_1            { Faker::Address.street_address }
    city                 { Faker::Address.city }
    state                { Faker::Address.us_state }
    postal_code          { Faker::Address.zip_code }
    country              'United States'
    fax_number           { Faker::PhoneNumber.phone_number }
    phone_number         { Faker::PhoneNumber.phone_number }
  end

  factory :supplier_term do
    terms { Faker::Lorem.paragraph }
  end

  factory :contractor_term do
    terms               { Faker::Lorem.paragraph }
    title               { Faker::Name.name }
    submission_criteria { Faker::Lorem.paragraph }
  end

  factory :insurance_information do
    expires_on (Date.today + 1.year)
  end

  factory :insurance_document do
  end

  factory :contact do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    email        { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end

  factory :contact_group do
    name  'Legal'
  end

  factory :property do |p|
    name              { Faker::Name.name }
    short_description { Faker::Lorem.paragraph[0..249] }
    long_description  { Faker::Lorem.paragraphs[0..999] }
  end

  factory :accommodation do |p|
    name              { Faker::Name.name }
    short_description { Faker::Lorem.paragraph[0..249] }
    long_description  { Faker::Lorem.paragraphs[0..999] }
  end

  factory :non_accommodation do |p|
    name              { Faker::Name.name }
    short_description { Faker::Lorem.paragraph[0..249] }
    long_description  { Faker::Lorem.paragraphs[0..999] }
  end

  factory :image do
  end

  factory :property_policy do
  end

  factory :special_offer do
  end

  factory :stay_pay_deal do
  end

  factory :stay_pay_offer do
  end

  factory :room_upgrade do
  end

  factory :room_upgrade_offer do
  end

  factory :bonus_offer do
  end

  factory :transfer do
  end

  factory :invitation do
    company_name { Faker::Name.name }
    email        { Faker::Internet.email }
    user
  end

  factory :simple_date_range do
  end

  factory :departure_date_range do
  end

  factory :named_date_range do
    name { Faker::Name.name }
  end

  factory :season do
    name { Faker::Name.name }
  end

  factory :blackout_period do
    name { Faker::Name.name }
  end

  factory :special_pricing_period do
    name { Faker::Name.name }
  end

  factory :product do
    name { Faker::Name.name }
  end

  factory :accommodation_product do
    name  { Faker::Name.name }
  end

  factory :non_accommodation_product do
    name  { Faker::Name.name }
  end

  factory :product_rate_group do
  end

  factory :product_rate_base do
  end

  factory :product_rate do
  end

  factory :weekend_rate do
  end

  factory :price_info do
  end

  factory :room_detail do
  end

  factory :room_rate do
  end

  factory :meal_rate_base do
  end

  factory :meal_rate do
  end

  factory :special_event_meal do
  end

end