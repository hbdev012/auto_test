require 'spec_helper'

describe CorporateInformation do

  before do
    @company = Factory.create :supplier
    @company.supplier_corporate_information = Factory.build :supplier_corporate_information
  end

  it 'should allow creation with valid attributes' do
    @company.save.should be_true
  end

  %w(Accommodation Non-Accommodation Rental).each do |product_type|
    it "should have #{product_type} as a PRODUCT_TYPES" do
      SupplierCorporateInformation::PRODUCT_TYPES.should include(product_type)
    end
  end

  describe 'validations' do

    it 'should require a product type' do
      @company.supplier_corporate_information.product_type = ''
      @company.should_not be_valid
    end

    it 'should require a known product type' do
      SupplierCorporateInformation::PRODUCT_TYPES.each do |pt|
        @company.supplier_corporate_information.product_type = pt
        @company.should be_valid
      end

      @company.supplier_corporate_information.product_type = 'Not valid'
      @company.should_not be_valid
    end

    it 'should require direct products to be true or false' do
      @company.supplier_corporate_information.direct_products = nil
      @company.should_not be_valid

      @company.supplier_corporate_information.direct_products = true
      @company.should be_valid

      @company.supplier_corporate_information.direct_products = false
      @company.should be_valid
    end

  end

end
