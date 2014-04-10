require 'spec_helper'

describe MealRateBase do

  before do
    Time.zone = 'UTC'
    @room_rate = Factory.build :room_rate
    @meal_rate_base = @room_rate.meal_rates.build Factory.attributes_for(:meal_rate_base)
  end

  it 'allows creation if valid' do
    @room_rate.save.should be_true
  end

  describe 'relations' do

    it 'embedded in room rate' do
      @meal_rate_base.relations.should include("room_rate")
    end

  end

end
