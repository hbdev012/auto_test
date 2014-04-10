require 'spec_helper'

describe DepartureDateRange do

  before do
    Time.zone = 'UTC'
    @product_rate_group = Factory.build :product_rate_group
    @departure_date_range = @product_rate_group.departure_date_ranges.build Factory.attributes_for(:departure_date_range)
  end

  it 'allows creation if valid' do
    @product_rate_group.save.should be_true
  end

  describe 'relations' do

    it 'embedded in product' do
      @departure_date_range.relations.should include("product_rate_group")
    end

  end

end
