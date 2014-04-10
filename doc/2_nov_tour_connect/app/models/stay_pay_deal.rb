class StayPayDeal < SpecialOffer

## Associations
  belongs_to :accommodation

  embeds_many :stay_pay_date_ranges, :as => :offerable, :class_name => 'SpecialOfferDateRange'
  embeds_many :stay_pay_offers

  with_options :allow_destroy => true do |stay_pay_deal|
    stay_pay_deal.accepts_nested_attributes_for :stay_pay_date_ranges
    stay_pay_deal.accepts_nested_attributes_for :stay_pay_offers
  end

## Fields
  field :partial_offers,      :type => Boolean
  field :standard_meal_offer, :type => Boolean

end
