require 'spec_helper'

describe SpecialOffer do

  before do
    @special_offer = Factory.build(:special_offer)
  end

  it 'allows save if valid' do
    @special_offer.save.should be_true
  end

end
