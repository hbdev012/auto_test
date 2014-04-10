class StayPayOffer
  include Mongoid::Document

## Associations
  embedded_in :stay_pay_deal

## Fields
  field :stay,              :type => Integer
  field :pay,               :type => Integer
  field :name,              :type => String
  field :comment,           :type => String
  field :apply_for_weekend, :type => Boolean

## Validations
  with_options :numericality => { :greater_than_or_equal_to => 0 }, :allow_blank => true do |stay_pay_offer|
    stay_pay_offer.validates :stay
    stay_pay_offer.validates :pay
  end
end
