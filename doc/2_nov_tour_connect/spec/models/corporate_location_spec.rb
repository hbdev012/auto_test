require 'spec_helper'

describe CorporateLocation do

  before do
    @location = Factory.build :corporate_location
  end

  it 'should be creatable' do
    @location.save.should be_true
  end

  describe 'validations' do

    it 'requires a corporate identifier' do
      @location.corporate_identifier = ''
      @location.should_not be_valid
    end

  end

end
