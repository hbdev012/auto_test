require 'spec_helper'

describe InsuranceDocument do

  before do
    @supplier = Factory.create :supplier
    @insurance_information = @supplier.build_insurance_information Factory.attributes_for(:insurance_information)
    @insurance_document = @insurance_information.insurance_documents.build Factory.attributes_for(:insurance_document)
  end

  it 'should allow creation if valid' do
    @supplier.should be_valid
  end

  describe 'validations' do

    it 'allows .pdf filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.pdf')
      @supplier.should be_valid
    end

    it 'allows .jpg filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.jpg')
      @supplier.should be_valid
    end

    it 'allows .jpeg filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.jpeg')
      @supplier.should be_valid
    end

    it 'allows .tiff filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.tiff')
      @supplier.should be_valid
    end

    it 'allows .doc filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.doc')
      @supplier.should be_valid
    end

    it 'allows .docx filetype' do
      @insurance_document.attachment = File.new('spec/data/insurance.docx')
      @supplier.should be_valid
    end

    it 'disallows non .pdf, .jpg, .jpeg, .tiff, .doc and .docx filetypes' do
      @insurance_document.attachment = File.new('spec/data/insurance.pages')
      @supplier.should_not be_valid
    end

  end

end