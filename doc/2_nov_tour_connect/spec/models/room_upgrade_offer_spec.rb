require 'spec_helper'

describe RoomUpgrade do

  before do
    @room_upgrade = Factory.build(:room_upgrade)
    @room_upgrade_offer = @room_upgrade.room_upgrade_offers.build Factory.attributes_for(:room_upgrade_offer)
  end

  it 'allows save if valid' do
    @room_upgrade.save.should be_true
  end

end
