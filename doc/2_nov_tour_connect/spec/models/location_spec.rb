require 'spec_helper'

describe Location do

  before do
    @location = Factory.build :location
  end

  it 'should be creatable' do
    @location.save.should be_true
  end

  describe 'validations' do

    it 'requires a phone number' do
      @location.phone_number = ''
      @location.should_not be_valid
    end

    it 'requires a fax number' do
      @location.fax_number = ''
      @location.should_not be_valid
    end

    it 'requires an address 1' do
      @location.address_1 = ''
      @location.should_not be_valid
    end

    it 'requires a city' do
      @location.city = ''
      @location.should_not be_valid
    end

    it 'requires a state' do
      @location.state = ''
      @location.should_not be_valid
    end

    it 'requires a postal code' do
      @location.postal_code = ''
      @location.should_not be_valid
    end

    it 'requires a country' do
      @location.country = ''
      @location.should_not be_valid
    end

  end

end
