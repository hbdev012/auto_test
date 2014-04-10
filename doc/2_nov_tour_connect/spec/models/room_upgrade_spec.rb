require 'spec_helper'

describe RoomUpgrade do

  before do
    @room_upgrade = Factory.build(:room_upgrade)
  end

  it 'allows save if valid' do
    @room_upgrade.save.should be_true
  end

end
