require 'spec_helper'

describe CorporateInformation do

  before do
    @company = Factory.create :company
    @company.corporate_information = Factory.build :corporate_information
  end

  it 'should allow creation with valid attributes' do
    @company.save.should be_true
  end

  describe 'validations' do

    it 'requires description' do
      @company.corporate_information.description = ''
      @company.should_not be_valid
    end

  end

  describe 'logo' do

    it 'allows .jpg filetype' do
      @company.corporate_information.logo = File.new('spec/data/logo.jpg')
      @company.should be_valid
    end

    it 'allows .jpeg filetype' do
      @company.corporate_information.logo = File.new('spec/data/logo.jpeg')
      @company.should be_valid
    end

    it 'allows .png filetype' do
      @company.corporate_information.logo = File.new('spec/data/logo.png')
      @company.should be_valid
    end

    it 'allows .gif filetype' do
      @company.corporate_information.logo = File.new('spec/data/logo.gif')
      @company.should be_valid
    end

    it 'disallows non .jpg, .png, and .gif filetypes' do
      @company.corporate_information.logo = File.new('spec/data/logo.pdf')
      @company.should_not be_valid
    end

    it 'allows for a maximum file size of 300K' do
      @company.corporate_information.logo = File.new('spec/data/big_logo.png')
      @company.should_not be_valid
    end

  end

end
