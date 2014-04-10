require 'spec_helper'

describe StayPayDeal do

  before do
    @staypaydeal = Factory.build(:stay_pay_deal)
  end

  it 'allows creation if valid' do
    @staypaydeal.save.should be_true
  end

end
