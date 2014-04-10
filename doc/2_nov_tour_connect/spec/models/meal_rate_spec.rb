require 'spec_helper'

describe MealRate do

  before do
    Time.zone = 'UTC'
    @room_rate = Factory.build :room_rate
    @meal_rate = @room_rate.meal_rates.build Factory.attributes_for(:meal_rate)
  end

  it 'allows creation if valid' do
    @room_rate.save.should be_true
  end

end
