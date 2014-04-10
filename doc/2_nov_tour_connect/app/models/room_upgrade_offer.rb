class RoomUpgradeOffer
  include Mongoid::Document

## Associations
  embedded_in :room_upgrade

## Fields
  with_options :type => String do |room_upgrade|
    room_upgrade.field :from_room_type
    room_upgrade.field :to_room_type
  end
end