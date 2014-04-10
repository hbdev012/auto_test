require 'spec_helper'

describe ProductRateBase do

  before do
    @product_rate_base = Factory.build(:product_rate_base)
  end

  it 'allows creation if valid' do
    @product_rate_base.save.should be_true
  end

  describe 'relations' do

    it 'embeds one price info' do
      @product_rate_base.relations.should include("price_info")
    end

  end

end
