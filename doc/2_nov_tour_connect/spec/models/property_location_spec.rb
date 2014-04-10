require 'spec_helper'

describe PropertyLocation do

  before do
    @location = Factory.build :property_location
  end

  it 'should be creatable' do
    @location.save.should be_true
  end

end
