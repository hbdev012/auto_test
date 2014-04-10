class Season < NamedDateRange

## Associations
  belongs_to :property

  embeds_many :blackout_periods, :as => :blackoutable
  embeds_many :special_pricing_periods, :as => :special_priceable

  accepts_nested_attributes_for :blackout_periods,        :allow_destroy => true
  accepts_nested_attributes_for :special_pricing_periods, :allow_destroy => true

## Validations
  validate :overlapping_dates

private

  def overlapping_dates
    # Blackout dates cannot overlap each other
    self.blackout_periods.each do |blackout|
      self.errors.add(:blackout_periods, " - #{blackout.name} overlaps with another blackout date") if blackout.overlap?(self.blackout_periods)
    end

    # Special pricing dates cannot overlap each other or blackout dates
    self.special_pricing_periods.each do |special_pricing|
      self.errors.add(:special_pricing_periods, " - #{special_pricing.name} overlaps with another special pricing date") if special_pricing.overlap?(self.special_pricing_periods)
      self.errors.add(:special_pricing_periods, " - #{special_pricing.name} overlaps with a blackout date") if special_pricing.overlap?(self.blackout_periods)
    end
  end

end
