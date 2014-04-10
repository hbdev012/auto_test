require 'spec_helper'

describe Image do

  before do
    @supplier      = Factory.create :supplier
    @accommodation = Factory.build :accommodation
    @supplier.properties << @accommodation

    @image = @accommodation.images.build Factory.attributes_for(:image)
  end

  it 'allows save if valid' do
    @accommodation.save.should be_true
  end

  describe 'validations' do

    it 'allows .jpg filetype' do
      @image.attachment = File.new('spec/data/logo.jpg')
      @accommodation.should be_valid
    end

    it 'allows .jpeg filetype' do
      @image.attachment = File.new('spec/data/logo.jpeg')
      @accommodation.should be_valid
    end

    it 'allows .png filetype' do
      @image.attachment = File.new('spec/data/logo.png')
      @accommodation.should be_valid
    end

    it 'allows .gif filetype' do
      @image.attachment = File.new('spec/data/logo.gif')
      @accommodation.should be_valid
    end

    it 'disallows non .jpg, .jpeg, .png or .gif filetypes' do
      @image.attachment = File.new('spec/data/logo.pdf')
      @accommodation.should_not be_valid
    end

    it 'allows for a maximum file size of 5MB' do
      @image.attachment = File.new('spec/data/6.6mb.jpg')
      @accommodation.should_not be_valid
    end

  end

end
