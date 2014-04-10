require 'spec_helper'

describe Accommodation do

  before do
    @supplier      = Factory.create :supplier
    @accommodation = Factory.build(:accommodation)
    @supplier.properties << @accommodation
  end

  it 'allows save if valid' do
    @accommodation.save.should be_true
  end
  
  describe 'defaults' do

    it 'defaults classifications to empty array' do
      @accommodation.classifications.should be_empty
    end

  end

  describe 'validations' do

    describe 'classifications' do

      Accommodation::CLASSIFICATIONS.each do |c|
        it "accepts #{c} as valid" do
          @accommodation.classifications = [c]
          @accommodation.should be_valid
        end
      end

      it 'disallows unknown classifications' do
        @accommodation.classifications = %w(unknown)
        @accommodation.should_not be_valid
      end

    end

    describe 'rating type' do

      Accommodation::RATING_TYPES.each do |r|
        it "accepts #{r} as valid" do
          @accommodation.rating_type = r
          @accommodation.should be_valid
        end
      end

      it 'allows nil rating type' do
        @accommodation.rating_type = nil
        @accommodation.should be_valid
      end

      it 'disallows unknown rating types' do
        @accommodation.rating_type = 'unknown'
        @accommodation.should_not be_valid
      end

    end

    it 'requires rating to be a number' do
      @accommodation.rating = 'a'
      @accommodation.should_not be_valid

      @accommodation.rating = 1
      @accommodation.should be_valid
    end

    it 'allows rating to be nil' do
      @accommodation.rating = nil
      @accommodation.should be_valid
    end

  end

  describe 'amenities' do

    it 'allows assignment' do
      @accommodation.amenities = %w(Pool)
      @accommodation.save!

      Property.find(@accommodation.id).amenities.should include('Pool')
    end

    it 'allows unassignment' do
      @accommodation.amenities = %w(Pool Babysitting)
      @accommodation.save!

      @accommodation.amenities = %w(Pool)
      @accommodation.save!

      Property.find(@accommodation.id).amenities.should include('Pool')
      Property.find(@accommodation.id).amenities.should_not include('Babysitting')

      @accommodation.amenities = %w()
      @accommodation.save!

      Property.find(@accommodation.id).amenities.should_not include('Pool')
      Property.find(@accommodation.id).amenities.should_not include('Babysitting')
    end

  end

  describe 'classifications' do

    it 'allows assignment' do
      @accommodation.classifications = %w(Hotel)
      @accommodation.save!

      Property.find(@accommodation.id).classifications.should include('Hotel')
    end

    it 'allows unassignment' do
      @accommodation.classifications = %w(Hotel Caravan)
      @accommodation.save!

      @accommodation.classifications = %w(Hotel)
      @accommodation.save!

      Property.find(@accommodation.id).classifications.should include('Hotel')
      Property.find(@accommodation.id).classifications.should_not include('Caravan')

      @accommodation.classifications = %w()
      @accommodation.save!

      Property.find(@accommodation.id).classifications.should_not include('Hotel')
      Property.find(@accommodation.id).classifications.should_not include('Caravan')
    end

  end

end