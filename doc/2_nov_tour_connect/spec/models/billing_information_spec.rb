require 'spec_helper'

describe BillingInformation do

  before do
    @company = Factory.create :company
    @company.billing_information = Factory.build :billing_information
  end

  it 'should allow creation with valid attributes' do
    @company.save.should be_true
  end

end
