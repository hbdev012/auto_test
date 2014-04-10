require 'spec_helper'

describe NamedDateRange do

  before do
    Time.zone = 'UTC'
    @named_date_range = Factory.build :named_date_range
  end

  it 'allows creation if valid' do
    @named_date_range.save.should be_true
  end

  describe 'validations' do

    it 'requires name' do
      @named_date_range.name = nil
      @named_date_range.should_not be_valid
    end

  end

end
