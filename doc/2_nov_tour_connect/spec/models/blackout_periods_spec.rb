require 'spec_helper'

describe BlackoutPeriod do

  before do
    Time.zone = 'UTC'
    @season = Factory.build :season
    @blackout_period = @season.blackout_periods.build Factory.attributes_for(:blackout_period)
  end

  it 'allows creation if valid' do
    @season.save.should be_true
  end

  describe 'relations' do

    it 'embedded in blackoutable (polymorphic)' do
      @blackout_period.relations.should include("blackoutable")
    end

  end

  describe 'validations' do

    describe 'begins on' do

      it 'must not be less than season date range' do
        @blackout_period.begins_on = @season.begins_on - 1.week
        @season.should_not be_valid
      end

      it 'must not be greater than season date range' do
        @blackout_period.begins_on = @season.begins_on + 1.week
        @season.should_not be_valid
      end

    end

    describe 'ends on' do

      it 'must not be less than season date range' do
        @blackout_period.ends_on = @season.begins_on - 1.week
        @season.should_not be_valid
      end

      it 'must not be greater than season date range' do
        @blackout_period.ends_on = @season.begins_on + 1.week
        @season.should_not be_valid
      end

    end

  end

end
