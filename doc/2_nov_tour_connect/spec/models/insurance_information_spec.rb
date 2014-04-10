require 'spec_helper'

describe InsuranceInformation do

  before do
    @supplier = Factory.create :supplier
    @insurance_information = @supplier.build_insurance_information Factory.attributes_for(:insurance_information)
  end

  it 'should allow creation if valid' do
    @supplier.save.should be_true
  end

  describe 'validations' do

    it 'should require expiration date' do
      @insurance_information.expires_on = nil
      @supplier.should_not be_valid
    end

  end

end