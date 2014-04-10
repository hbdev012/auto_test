require 'spec_helper'

describe RoomRate do

  before do
    Delorean.time_travel_to "2011-01-01"

    @supplier = Factory.build :supplier
    @supplier.build_billing_information
    @supplier.save!

    @property = Factory.build :accommodation
    @supplier.properties << @property

    @accommodation_product = Factory.build :accommodation_product
    @property.products << @accommodation_product

    @room_rate = @accommodation_product.room_rates.build Factory.attributes_for(:room_rate)
  end

  after do
    Delorean.back_to_the_present
  end

  it 'allows save if valid' do
    @accommodation_product.save.should be_true
  end

  describe 'relations' do

    it 'belongs to season' do
      @room_rate.relations['season'].should be_present
    end

    it 'embeds many validity dates' do
      @room_rate.relations['validity_dates'].should be_present
    end

    it 'embeds many product rates' do
      @room_rate.relations['product_rates'].should be_present
    end

    it 'embeds many weekend rates' do
      @room_rate.relations['weekend_rates'].should be_present
    end

    it 'embeds many stay pay offers' do
      @room_rate.relations['stay_pay_offers'].should be_present
    end

    it 'embeds many meal rates' do
      @room_rate.relations['meal_rates'].should be_present
    end

    it 'embeds many special event meals' do
      @room_rate.relations['special_event_meals'].should be_present
    end

  end

end
