require 'spec_helper'

describe SupplierTerm do

  before do
    @supplier = Factory.create :supplier
    @supplier_term = @supplier.build_supplier_term Factory.build(:supplier_term).attributes.except('_id')
  end

  it 'should be creatable' do
    @supplier.save.should be_true
  end

  describe 'validations' do

    it 'requires terms' do
      @supplier_term.terms = ''
      @supplier.should_not be_valid
    end

  end

end
