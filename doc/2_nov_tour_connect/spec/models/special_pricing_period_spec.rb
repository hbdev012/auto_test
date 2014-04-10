require 'spec_helper'

describe SpecialPricingPeriod do

  before do
    Time.zone = 'UTC'
    @season = Factory.build :season
    @special_pricing_period = @season.special_pricing_periods.build Factory.attributes_for(:special_pricing_period)
  end

  it 'allows creation if valid' do
    @season.save.should be_true
  end

  describe 'relations' do

    it 'embedded in special priceable (polymorphic)' do
      @special_pricing_period.relations.should include("special_priceable")
    end

    it 'embeds one season' do
      @special_pricing_period.relations.should include("price_info")
    end

  end

  describe 'validations' do

    describe 'begins on' do

      it 'must not be less than season date range' do
        @special_pricing_period.begins_on = @season.begins_on - 1.week
        @season.should_not be_valid
      end

      it 'must not be greater than season date range' do
        @special_pricing_period.begins_on = @season.begins_on + 1.week
        @season.should_not be_valid
      end

    end

    describe 'ends on' do

      it 'must not be less than season date range' do
        @special_pricing_period.ends_on = @season.begins_on - 1.week
        @season.should_not be_valid
      end

      it 'must not be greater than season date range' do
        @special_pricing_period.ends_on = @season.begins_on + 1.week
        @season.should_not be_valid
      end

    end

  end

end
