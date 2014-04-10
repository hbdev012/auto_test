require 'spec_helper'

describe BonusOffer do

  before do
    @bonus_offer = Factory.build(:bonus_offer)
  end

  it 'allows save if valid' do
    @bonus_offer.save.should be_true
  end

  describe 'validations' do

    [:number_of_guests, :max_number_of_guests, :discount_amount, :net_rate, :commission_percent].each do |a|
      it "requires #{a} to be an integer > 0" do
        [-1, 'invalid'].each do |bad|
          @bonus_offer.send(:"#{a}=", bad)
          @bonus_offer.should_not be_valid
        end

        [0, 1, 42].each do |good|
          @bonus_offer.send(:"#{a}=", good)
          @bonus_offer.should be_valid
        end
      end

    end

  end

end
