require 'spec_helper'

describe RoomDetail do

  before do
    Delorean.time_travel_to "2011-01-01"

    @supplier = Factory.build :supplier
    @supplier.build_billing_information
    @supplier.save!

    @property = Factory.build :accommodation
    @supplier.properties << @property

    @accommodation_product = Factory.build :accommodation_product
    @property.products << @accommodation_product

    @room_detail = @accommodation_product.build_room_detail Factory.attributes_for(:room_detail)
  end

  after do
    Delorean.back_to_the_present
  end

  it 'allows save if valid' do
    @accommodation_product.save.should be_true
  end

  describe 'relations' do

    it 'embedded in accommodation product' do
      @room_detail.relations['accommodation_product'].should be_present
    end

  end

end
