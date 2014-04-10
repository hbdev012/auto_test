require 'spec_helper'

describe NonAccommodationProduct do

  before do
    Time.zone = 'UTC'

    property = Factory.build :property
    @product = Factory.build :non_accommodation_product

    property.products << @product
  end

  it 'allows creation if valid' do
    @product.save.should be_true
  end

  describe '#inherited_bonus_offers=' do

    it 'converts non BSON ids to BSON' do
      id = BSON::ObjectId.new.to_s
      id2 = BSON::ObjectId.new.to_s
      @product.inherited_bonus_offers = [id, id2]

      @product.inherited_bonus_offers.should have(2).entries
      @product.inherited_bonus_offers.each {|bo| bo.is_a?(BSON::ObjectId).should be_true }
    end

    it 'does not convert BSON ids' do
      id = BSON::ObjectId.new
      id2 = BSON::ObjectId.new
      @product.inherited_bonus_offers = [id, id2]

      @product.inherited_bonus_offers.should have(2).entries
      @product.inherited_bonus_offers.each {|bo| bo.is_a?(BSON::ObjectId).should be_true }
    end

  end

end
