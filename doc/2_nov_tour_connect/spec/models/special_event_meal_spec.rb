require 'spec_helper'

describe SpecialEventMeal do

  before do
    Time.zone = 'UTC'
    @room_rate = Factory.build :room_rate
    @special_event_meal = @room_rate.special_event_meals.build Factory.attributes_for(:special_event_meal)
  end

  it 'allows creation if valid' do
    @room_rate.save.should be_true
  end

end
