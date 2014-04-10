class ProductRateGroup
  include Mongoid::Document
  include Mongoid::Timestamps

## Associations
  belongs_to :non_accommodation_product
  belongs_to :season

  embeds_one  :product_market,          :as => :product_marketable
  embeds_many :blackout_periods,        :as => :blackoutable
  embeds_many :departure_date_ranges
  embeds_many :product_rates,           :as => :product_rateable
  embeds_many :special_pricing_periods, :as => :special_priceable

  with_options :allow_destroy => true do |product_rate_group|
    product_rate_group.accepts_nested_attributes_for :blackout_periods
    product_rate_group.accepts_nested_attributes_for :departure_date_ranges
    product_rate_group.accepts_nested_attributes_for :product_rates
    product_rate_group.accepts_nested_attributes_for :special_pricing_periods
  end

## Fields
  with_options :type => Boolean, :default => false do |product_rate_group|
    product_rate_group.field :gst_tax_included
    product_rate_group.field :include_meal
  end

  with_options :type => String do |product_rate_group|
    product_rate_group.field :departs
    product_rate_group.field :meal_details
  end

  field :departure_week_days, :type => Hash, :default => { 'sun' => false, 'mon' => false, 'tues' => false, 'wed' => false, 'thur' => false, 'fri' => false, 'sat' => false }

## Delegations
  # Rate group is bounded by the season dates. See special pricing and blackout date validations.
  delegate :begins_on, :to => :season
  delegate :ends_on,   :to => :season

## Validations
  validate :season, :presence => true

  with_options :inclusion => { :in => [true, false] } do |product_rate_group|
    product_rate_group.validates :gst_tax_included
    product_rate_group.validates :include_meal
  end

## Callbacks
  before_validation :nillify_fields

## Instance Methods
  def departure_week_days=(values={})
    values.each { |k, v| values[k] = v.is_a?(Boolean) ? v : v == 'true' }
    write_attribute(:departure_week_days, values)
  end

  def prepare_product_rate_group
    initialize_dependencies
  end

private

  def initialize_dependencies
    if self.season.present?
      self.season.special_pricing_periods.each do |special_pricing_period|
        if self.special_pricing_periods.to_a.detect { |p| p.inherited_id == special_pricing_period.id.to_s }.nil?
          self.special_pricing_periods.build(:inherited_id => special_pricing_period.id)
        end
      end
    end
  end

  def nillify_fields
    unless self.include_meal
      self.meal_details = nil
    end
  end

end
