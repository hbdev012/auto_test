require 'spec_helper'

describe StayPayOffer do

  before do
    @staypaydeal  = Factory.build :stay_pay_deal
    @staypayoffer = @staypaydeal.stay_pay_offers.build Factory.attributes_for(:stay_pay_offer)
  end

  it 'allows creation if valid' do
    @staypaydeal.save.should be_true
  end

  describe 'validations' do

    [:stay, :pay].each do |a|
      it "requires #{a} to be an integer > 0" do
        [-1, 'invalid'].each do |bad|
          @staypayoffer.send(:"#{a}=", bad)
          @staypaydeal.should_not be_valid
        end

        [0, 1, 42].each do |good|
          @staypayoffer.send(:"#{a}=", good)
          @staypaydeal.should be_valid
        end
      end

    end

  end

end
