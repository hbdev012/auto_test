require 'spec_helper'

describe PriceInfo do

  before do
    @product_rate_group = Factory.build :product_rate_group
    product_rate = @product_rate_group.product_rates.build Factory.attributes_for(:product_rate)
    @price_info = product_rate.build_price_info Factory.attributes_for(:price_info)
  end

  it 'allows creation if valid' do
    @product_rate_group.save.should be_true
  end

  describe 'relations' do

    it 'embedded in product' do
      @price_info.relations.should include("priceable")
    end

  end

  describe 'validations' do

    [:adult_rate, :child_rate, :infant_rate, :minimum_nights, :per_night_rate, :student_rate, :concession_rate].each do |a|
      it "requires #{a} to be a number" do
        @price_info.send(:"#{a}=", "not a number")
        @price_info.should_not be_valid

        @price_info.send(:"#{a}=", 1)
        @price_info.should be_valid
      end

    end

  end

end
