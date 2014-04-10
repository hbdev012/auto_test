require 'spec_helper'

describe WeekendRate do

  before do
    @room_rate = Factory.build(:room_rate)
    @weekend_rate = @room_rate.weekend_rates.build Factory.attributes_for(:weekend_rate)
  end

  it 'allows creation if valid' do
    @room_rate.save.should be_true
  end

  describe 'relations' do

    it 'embedded in product rateable' do
      @weekend_rate.relations.should include("weekend_rateable")
    end

  end

end
