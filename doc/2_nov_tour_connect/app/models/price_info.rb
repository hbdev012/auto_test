class PriceInfo
  include Mongoid::Document

## Associations
  embedded_in :priceable, :polymorphic => true

## Fields
  field :price_code, :type => String

  with_options :type => Float do |price_info|
    price_info.field :adult_rate
    price_info.field :child_rate
    price_info.field :infant_rate
    price_info.field :minimum_nights
    price_info.field :per_night_rate
    price_info.field :student_rate
    price_info.field :concession_rate
  end

## Validations
  with_options :numericality => { :allow_blank => true, :greater_than_or_equal_to => 0 } do |price_info|
    price_info.validates :adult_rate
    price_info.validates :child_rate
    price_info.validates :infant_rate
    price_info.validates :minimum_nights
    price_info.validates :per_night_rate
    price_info.validates :student_rate
    price_info.validates :concession_rate
  end

end
