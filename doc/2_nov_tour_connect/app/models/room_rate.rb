class RoomRate
  include Mongoid::Document

## Association
  belongs_to :accommodation_product
  belongs_to :season

  embeds_one :product_market, :as => :product_marketable

  embeds_many :meal_rates
  embeds_many :product_rates,       :as => :product_rateable
  embeds_many :special_event_meals
  embeds_many :stay_pay_offers
  embeds_many :validity_dates,      :class_name => 'SimpleDateRange'
  embeds_many :weekend_rates,       :as => :weekend_rateable

  with_options :allow_destroy => true do |room_rate|
    room_rate.accepts_nested_attributes_for :meal_rates
    room_rate.accepts_nested_attributes_for :product_rates
    room_rate.accepts_nested_attributes_for :special_event_meals
    room_rate.accepts_nested_attributes_for :stay_pay_offers
    room_rate.accepts_nested_attributes_for :validity_dates
    room_rate.accepts_nested_attributes_for :weekend_rates
  end

## Fields
  with_options :type => String do |room_rate|
    room_rate.field :inclusion
    room_rate.field :rate_type
    room_rate.field :weekend_days
  end

  field :stay_pay_available,         :type => Boolean
  field :weekend_same_as_other_days, :type => Boolean
  field :weekend_minimum_nights,     :type => Integer

## Validations
  validates :weekend_minimum_nights, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true }

## Callbacks
  before_validation :nillify_fields

private

  def nillify_fields
    if self.weekend_same_as_other_days?
      self.weekend_days = nil
      self.weekend_minimum_nights = nil
      # self.weekend_rates.clear

      # # Destroy any weekend rate options
      # weekend_rates_hash = {}
      # self.weekend_rates.each_with_index do |wr, index|
      #   weekend_rates_hash[index.to_s] = {
      #     "_destroy" => "1",
      #     "id" => wr.id.to_s
      #   }
      # end
      #
      # self.attributes = { :weekend_rates_attributes => weekend_rates_hash }
    end
  end

end
