require 'spec_helper'

describe AccommodationProduct do

  before do
    property = Factory.build :property
    @product = Factory.build :accommodation_product

    property.products << @product
  end

  it 'allows creation if valid' do
    @product.save.should be_true
  end

  it 'number_of_rooms should be a number' do
    @product.allocation_type = 'allotment'
    @product.number_of_rooms = 'abc'
    @product.should_not be_valid
  end

  it 'releaseback_days should be a number' do
    @product.allocation_type = 'allotment'
    @product.releaseback_days = 'abc'
    @product.should_not be_valid
  end

end
