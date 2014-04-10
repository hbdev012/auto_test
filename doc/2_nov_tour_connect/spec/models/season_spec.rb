require 'spec_helper'

describe Season do

  before do
    Time.zone = 'UTC'
    @season = Factory.build :season, :begins_on => 1.month.ago.to_date, :ends_on => 2.months.from_now.to_date
  end

  describe 'relations' do

    it 'has many blackout periods' do
      @season.relations.should include("blackout_periods")
    end

    it 'has many special pricing periods' do
      @season.relations.should include("special_pricing_periods")
    end

  end

  describe 'validations' do

    describe 'overlaps' do

      before do
        @blackout  = Factory.build :blackout_period, :begins_on => Date.today - 1.week, :ends_on => Date.today + 1.week
        @blackout2 = Factory.build :blackout_period, :begins_on => Date.today - 1.week, :ends_on => Date.today + 1.week

        @special_pricing  = Factory.build :special_pricing_period, :begins_on => Date.today - 1.week, :ends_on => Date.today + 1.week
        @special_pricing2 = Factory.build :special_pricing_period, :begins_on => Date.today - 1.week, :ends_on => Date.today + 1.week
      end

      it 'disallows overlapping blackout dates' do
        @season.blackout_periods << @blackout
        @season.should be_valid

        @season.blackout_periods << @blackout2
        @season.should_not be_valid
      end

      it 'disallows overlapping special pricing dates' do
        @season.special_pricing_periods << @special_pricing
        @season.should be_valid

        @season.special_pricing_periods << @special_pricing2
        @season.should_not be_valid
      end

      it 'disallows special pricing overlapping with blackout dates' do
        @season.blackout_periods << @blackout
        @season.should be_valid

        @season.special_pricing_periods << @special_pricing
        @season.should_not be_valid
      end

    end

    describe 'constraints' do

      it 'blackout dates should be within their season date range' do
        @blackout = @season.blackout_periods.build Factory.attributes_for(:blackout_period, :begins_on => @season.begins_on,
                                                                                            :ends_on   => @season.begins_on + 1.week)

        @season.should be_valid

        @blackout.begins_on = @season.begins_on - 1.day
        @season.should_not be_valid

        @blackout.begins_on = @season.begins_on + 1.day
        @blackout.ends_on   = @season.ends_on + 1.day
        @season.should_not be_valid

        @blackout.begins_on = @season.begins_on - 1.day
        @blackout.ends_on   = @season.ends_on + 1.day
        @season.should_not be_valid
      end

      it 'special pricing dates should be within their season date range' do
        @special_pricing = @season.special_pricing_periods.build Factory.attributes_for(:special_pricing_period, :begins_on => @season.ends_on - 1.week,
                                                                                                                 :ends_on   => @season.ends_on)

        @season.should be_valid

        @special_pricing.begins_on = @season.begins_on - 1.day
        @season.should_not be_valid

        @special_pricing.begins_on = @season.begins_on + 1.day
        @special_pricing.ends_on   = @season.ends_on + 1.day
        @season.should_not be_valid

        @special_pricing.begins_on = @season.begins_on - 1.day
        @special_pricing.ends_on   = @season.ends_on + 1.day
        @season.should_not be_valid
      end

    end

  end

end
