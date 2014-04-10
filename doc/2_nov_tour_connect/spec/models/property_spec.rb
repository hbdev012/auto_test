require 'spec_helper'

describe Property do

  before do
    Delorean.time_travel_to "2011-01-01"
    @supplier = Factory.create :supplier
    @property = @supplier.properties.build Factory.attributes_for(:property)
  end

  after do
    Delorean.back_to_the_present
  end

  it 'allows save if valid' do
    @property.save.should be_true
  end

  describe 'relations' do

    it 'has many contact groups' do
      contact_group_relation = @property.relations['contact_groups']

      contact_group_relation.should be_present
      contact_group_relation.should be_autosave
    end

    it 'should have many property locations' do
      property_location_relation = @property.relations['property_locations']

      property_location_relation.should be_present
      property_location_relation.should be_autosave
    end

    it 'should have billing information' do
      @property.relations['billing_information'].should be_present
    end

    it 'should have insurance information' do
      @property.relations['insurance_information'].should be_present
    end

  end

  describe 'defaults' do

    it 'defaults use_corporate_billing_information' do
      @property.use_corporate_billing_information.should be_true
    end

    it 'defaults use_corporate_supplier_term' do
      @property.use_corporate_supplier_term.should be_true
    end

    it 'defaults use_corporate_insurance_information' do
      @property.use_corporate_insurance_information.should be_true
    end

  end

  describe 'validations' do

    it 'requires a name' do
      @property.name = ''
      @property.should_not be_valid
    end

    it 'requires a short_description' do
      @property.short_description = ''
      @property.should_not be_valid
    end

    it 'requires a long_description' do
      @property.long_description = ''
      @property.should_not be_valid
    end

    it 'short_description has 250 character max length' do
      @property.short_description = 'a' * 250
      @property.should be_valid

      @property.short_description += 'a'
      @property.should_not be_valid
    end

    it 'long_description has 1000 character max length' do
      @property.long_description = 'a' * 1000
      @property.should be_valid

      @property.long_description += 'a'
      @property.should_not be_valid
    end

    describe 'seasons' do

      it 'seasons should not overlap other seasons within the property' do
        @property.seasons.build Factory.attributes_for(:season, :begins_on => 1.month.ago.to_date, :ends_on => 2.months.from_now.to_date)
        @property.seasons.build Factory.attributes_for(:season, :begins_on => Date.today,          :ends_on => 2.months.from_now.to_date)

        @property.should_not be_valid
      end

      it 'sesaons can overlap other seasons from different properties' do
        property_b = @supplier.properties.build Factory.attributes_for(:property)

        @property.seasons.build Factory.attributes_for(:season,  :begins_on => 1.month.ago.to_date, :ends_on => 2.months.from_now.to_date)
        property_b.seasons.build Factory.attributes_for(:season, :begins_on => Date.today,          :ends_on => 2.months.from_now.to_date)

        @property.should be_valid
        property_b.should be_valid
      end

    end

  end

  describe 'corporate' do

    describe 'billing information' do

      before do
        @supplier.billing_information = Factory.build(:billing_information)
        @supplier.save!

        @property.billing_information = Factory.build(:billing_information)
        @property.save!
      end

      it 'uses the corporate information' do
        @property.use_corporate_billing_information = true

        @property.billing_information.should == @property.supplier.billing_information
      end

      it 'does not use the corporate information' do
        @property.use_corporate_billing_information = false

        @property.billing_information.should_not == @property.supplier.billing_information
      end

    end

    describe 'insurance information' do

      before do
        @supplier.insurance_information = Factory.build(:insurance_information)
        @supplier.save!

        @property.insurance_information = Factory.build(:insurance_information)
        @property.save!
      end

      it 'uses the corporate information' do
        @property.use_corporate_insurance_information = true

        @property.insurance_information.should == @property.supplier.insurance_information
      end

      it 'does not use the corporate information' do
        @property.use_corporate_insurance_information = false

        @property.insurance_information.should_not == @property.supplier.insurance_information
      end

    end

  end

  describe '#prepare_property' do

    before do
      @property.prepare_property
    end

    it 'should initialize billing information' do
      @property.billing_information.should be_present
    end

    it 'should initialize insurance information' do
      @property.insurance_information.should be_present
    end

    it 'should initialize supplier term' do
      @property.supplier_term.should be_present
    end

    it 'should initialize a location' do
      @property.property_locations.should be_present
    end

    describe 'default contact groups' do

      Property::DEFAULT_CONTACT_GROUPS.each do |group|
        it "should initialize #{group} contact group" do
          cg = @property.contact_groups.detect { |cg| cg.name == group && cg.initial_group == true }

          cg.should be_present
          cg.contacts.should be_present
        end
      end

    end

  end

  describe '#has_season_gaps?' do

    before do
      @property.save!
    end

    it 'returns true if there are no seasons' do
      @property.should have_season_gaps
    end

    describe 'with single season' do

      before do
        @season = @property.seasons.create Factory.attributes_for(:season, :begins_on => Date.today.at_beginning_of_year, :ends_on => Date.today.at_end_of_year)
      end

      it 'returns true if not year-spanning at beginning' do
        @season.update_attribute(:begins_on, @season.begins_on + 1.day)
        @property.should have_season_gaps
      end

      it 'returns true if not year-spanning at end' do
        @season.update_attribute(:ends_on, @season.ends_on - 1.day)
        @property.should have_season_gaps
      end

      it 'returns false if year-spanning' do
        @property.should_not have_season_gaps
      end

    end

    describe 'with two seasons' do

      before do
        mid = Date.today.at_beginning_of_year + 6.months
        @season1 = @property.seasons.create Factory.attributes_for(:season, :begins_on => Date.today.at_beginning_of_year, :ends_on => mid)
        @season2 = @property.seasons.create Factory.attributes_for(:season, :begins_on => mid + 1.day, :ends_on => Date.today.at_end_of_year)
      end

      it 'returns true if not year spanning at the beginning' do
        @season1.update_attribute(:begins_on, @season1.begins_on + 1.day)
        @property.should have_season_gaps
      end

      it 'returns true if not year spanning in the middle' do
        @season1.update_attribute(:ends_on, @season1.ends_on - 1.day)
        @property.should have_season_gaps
      end

      it 'returns true if not year spanning at the end' do
        @season2.update_attribute(:ends_on, @season2.ends_on - 1.day)
        @property.should have_season_gaps
      end

      it 'returns false if seasons span the year' do
        @property.should_not have_season_gaps
      end

    end

    describe 'with multiple seasons' do

      before do
        q1 = Date.today.at_beginning_of_year + 3.months
        q2 = q1 + 3.months
        q3 = q2 + 3.months

        @season1 = @property.seasons.create Factory.attributes_for(:season, :begins_on => Date.today.at_beginning_of_year, :ends_on => q1)
        @season2 = @property.seasons.create Factory.attributes_for(:season, :begins_on => q1 + 1.day, :ends_on => q2)
        @season3 = @property.seasons.create Factory.attributes_for(:season, :begins_on => q2 + 1.day, :ends_on => q3)
        @season4 = @property.seasons.create Factory.attributes_for(:season, :begins_on => q3 + 1.day, :ends_on => Date.today.at_end_of_year)
      end

      it 'returns true if not year spanning at the beginning' do
        @season1.update_attribute(:begins_on, @season1.begins_on + 1.day)
        @property.should have_season_gaps
      end

      it 'returns true if not year spanning in the middle' do
        @season1.update_attribute(:ends_on, @season1.ends_on - 1.day)
        @property.should have_season_gaps
      end

      it 'returns true if not year spanning at the end' do
        @season2.update_attribute(:ends_on, @season2.ends_on - 1.day)
        @property.should have_season_gaps
      end

      it 'returns false if seasons span the year' do
        @property.should_not have_season_gaps
      end

    end

  end

end
