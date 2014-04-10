class RoomUpgrade < SpecialOffer

## Associations
  belongs_to :accommodation

  embeds_many :room_upgrade_date_ranges, :as => :offerable, :class_name => 'SpecialOfferDateRange'
  embeds_many :room_upgrade_offers

  accepts_nested_attributes_for :room_upgrade_date_ranges, :allow_destroy => true
  accepts_nested_attributes_for :room_upgrade_offers, :allow_destroy => true
end
