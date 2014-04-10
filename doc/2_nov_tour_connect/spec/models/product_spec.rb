require 'spec_helper'

describe Product do

  before do
    Time.zone = 'UTC'
    property = Factory.build :property
    @product = Factory.build :product, :property => property
  end

  it 'allows creation if valid' do
    @product.save.should be_true
  end

  describe 'relations' do

    it 'belongs to property' do
      @product.relations.should include("property")
    end

  end

  describe 'validations' do

    it 'requires name' do
      @product.name = nil
      @product.should_not be_valid
    end

    it 'requires property' do
      @product.property = nil
      @product.should_not be_valid
    end

  end

end
