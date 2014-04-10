class Location
  include Mongoid::Document
  include Mongoid::Timestamps

## Fields
  with_options :type => String do |location|
    location.field :address_1
    location.field :address_2
    location.field :city
    location.field :country
    location.field :fax_number
    location.field :phone_number
    location.field :postal_code
    location.field :state
    location.field :uri
  end

## Validations
  with_options :presence => true do |location|
    location.validates :address_1
    location.validates :city
    location.validates :country
    location.validates :fax_number
    location.validates :phone_number
    location.validates :postal_code
    location.validates :state
  end

end
