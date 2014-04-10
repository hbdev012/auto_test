require 'spec_helper'

describe ContractorTerm do

  before do
    @contractor = Factory.create :contractor
    @contractor_term = @contractor.contractor_terms.build Factory.build(:contractor_term).attributes.except('_id')
  end

  it 'should be creatable' do
    @contractor.save.should be_true
  end

  describe 'validations' do

    it 'requires terms' do
      @contractor_term.terms = ''
      @contractor.should_not be_valid
    end

    it 'requires submission_criteria' do
      @contractor_term.submission_criteria = ''
      @contractor.should_not be_valid
    end

    it 'requires title' do
      @contractor_term.title = ''
      @contractor.should_not be_valid
    end
  end

end
