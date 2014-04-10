require 'spec_helper'

describe ProductRate do

  before do
    @product_rate_group = Factory.build(:product_rate_group)
    @product_rate = @product_rate_group.product_rates.build Factory.attributes_for(:product_rate)
  end

  it 'allows creation if valid' do
    @product_rate_group.save.should be_true
  end

  describe 'relations' do

    it 'embedded in product rateable' do
      @product_rate.relations.should include("product_rateable")
    end

  end

end
