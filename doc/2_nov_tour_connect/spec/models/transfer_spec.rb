require 'spec_helper'

describe Transfer do

  before do
    @transfer = Factory.build :transfer
  end

  it 'allows creation if valid' do
    @transfer.save.should be_true
  end

  describe 'defaults' do

    [:provided_by_hotel, :include_baby_seats].each do |a|
      it "should default #{a} to false" do
        @transfer.send(a).should be_false
      end
    end

  end

  describe 'validations' do

   [
     :adult_one_way_commission_amount,
     :adult_one_way_net_rate,
     :adult_return_commission_amount,
     :adult_return_net_rate,
     :child_one_way_commission_amount,
     :child_one_way_net_rate,
     :child_return_commission_amount,
     :child_return_net_rate,
     :max_passengers
   ].each do | a |
      it "requires #{a} to be an integer > 0" do
       [-1, 'invalid'].each do | bad |
          @transfer.send(:"#{a}=", bad)
          @transfer.should_not be_valid
        end

       [0, 1, 42].each do | good |
          @transfer.send(:"#{a}=", good)
          @transfer.should be_valid
        end
      end

    end

    [:provided_by_hotel, :include_baby_seats].each do |a|
      it 'wants provided by hotel to be a boolean' do
        @transfer.send(:"#{a}=", true)
        @transfer.should be_valid

        @transfer.send(:"#{a}=", false)
        @transfer.should be_valid

        @transfer.send(:"#{a}=", 'invalid')
        @transfer.should_not be_valid
      end
    end

  end

end
