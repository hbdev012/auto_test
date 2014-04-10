require 'spec_helper'

describe Supplier do

  before do
    @supplier = Factory.build :supplier
  end

  it 'should allow creation if valid' do
    @supplier.save.should be_true
  end

  describe 'defaults' do

    it 'defaults amenities to the default amenities' do
      @supplier.amenities.should == Supplier::DEFAULT_AMENITIES
    end

  end

  describe 'amenities' do

    it 'allows assignment' do
      @supplier.amenities = %w(Pool)
      @supplier.save!

      Supplier.find(@supplier.id).amenities.should include('Pool')
    end

    it 'allows unassignment' do
      @supplier.amenities = %w(Pool Babysitting)
      @supplier.save!

      @supplier.amenities = %w(Pool)
      @supplier.save!

      Supplier.find(@supplier.id).amenities.should include('Pool')
      Supplier.find(@supplier.id).amenities.should_not include('Babysitting')

      @supplier.amenities = %w()
      @supplier.save!

      Supplier.find(@supplier.id).amenities.should_not include('Pool')
      Supplier.find(@supplier.id).amenities.should_not include('Babysitting')
    end

  end

  describe '#prepare_company' do

    before do
      @supplier.save

      user = Factory.create :user
      @supplier.users << user
      @supplier.assign_creator!(user)
      user.confirm!
    end

    it 'should create an initial supplier term' do
      @supplier.prepare_company

      @supplier.supplier_term.should be_present
    end

    it 'should create an initial insurance information' do
      @supplier.prepare_company

      @supplier.insurance_information.should be_present
    end

  end

end
