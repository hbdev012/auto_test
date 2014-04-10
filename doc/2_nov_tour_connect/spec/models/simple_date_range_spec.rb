require 'spec_helper'

describe SimpleDateRange do

  before do
    Time.zone = 'UTC'
    @simple_date_range = Factory.build :simple_date_range
  end

  it 'allows creation if valid' do
    @simple_date_range.save.should be_true
  end

  describe 'defaults' do

    it 'begins on to today' do
      @simple_date_range.begins_on.should == Time.zone.now.to_date
    end

    it 'ends on to today' do
      @simple_date_range.ends_on.should == Time.zone.now.to_date
    end

  end

  describe 'validations' do

    it 'requires begins on' do
      @simple_date_range.begins_on = nil
      @simple_date_range.should_not be_valid
    end

    it 'requires ends on' do
      @simple_date_range.ends_on = nil
      @simple_date_range.should_not be_valid
    end

    it 'requires begins on to be <= ends on' do
      @simple_date_range.ends_on = (@simple_date_range.begins_on - 1.day)
      @simple_date_range.should_not be_valid
    end

  end

  describe 'scopes' do

    describe '#in_range' do

      before do
        @begins = Date.parse('2012-01-01')
        @ends   = Date.parse('2012-12-31')

        @way_before = Factory.create(:simple_date_range, :begins_on => @begins - 2.months, :ends_on => @begins - 1.month)
        @way_after  = Factory.create(:simple_date_range, :begins_on => @ends + 1.month, :ends_on => @ends + 2.month)
      end

      after do
        @simple_date_range.save!

        ranges = SimpleDateRange.in_range(@begins, @ends)
        ranges.should include(@simple_date_range)
        ranges.should_not include(@way_before)
        ranges.should_not include(@way_after)
      end

      it 'finds ranges that span the beginning of the query range' do
        @simple_date_range.begins_on = @begins - 1.week
        @simple_date_range.ends_on   = @begins + 1.week
      end

      it 'finds ranges that are entirely within the query range' do
        @simple_date_range.begins_on = @begins + 1.week
        @simple_date_range.ends_on   = @ends - 1.week
      end

      it 'finds ranges that span the ending of the query range' do
        @simple_date_range.begins_on = @ends - 1.week
        @simple_date_range.ends_on   = @ends + 1.week
      end

    end

  end

end
