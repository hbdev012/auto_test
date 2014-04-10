require 'spec_helper'

describe ProductRateGroup do

  before do
    Time.zone = 'UTC'
    property = Factory.build :property
    season   = Factory.build :season
    @product = Factory.build :non_accommodation_product, :property => property
    @product_rate_group = @product.product_rate_groups.build Factory.attributes_for(:product_rate_group, :season => season)
  end

  it 'allows creation if valid' do
    @product_rate_group.save.should be_true
  end

  describe 'relations' do

    it 'belongs to product' do
      @product_rate_group.relations.should include("non_accommodation_product")
    end

    it 'belongs to season' do
      @product_rate_group.relations.should include("season")
    end

    it 'embeds many blackout periods' do
      @product_rate_group.relations.should include("blackout_periods")
    end

    it 'embeds many departure date ranges' do
      @product_rate_group.relations.should include("departure_date_ranges")
    end

    it 'embeds many product rates' do
      @product_rate_group.relations.should include("product_rates")
    end

    it 'embeds many special pricing periods' do
      @product_rate_group.relations.should include("blackout_periods")
    end

  end

  describe 'validations' do

    it 'requires property' do
      @product.property = nil
      @product.should_not be_valid
    end

  end

  describe 'callbacks' do

    describe 'before validation' do

      it 'nillifies the meal details' do
        @product_rate_group.include_meal = false
        @product_rate_group.meal_details = "The details"

        @product.valid?

        @product_rate_group.meal_details.should be_nil
      end

    end

  end

end
