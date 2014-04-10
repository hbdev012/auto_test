require 'spec_helper'

describe PropertyPolicy do
  before do
    @supplier      = Factory.create :supplier
    @accommodation = Factory.build(:accommodation)
    @supplier.properties << @accommodation

    @property_policy = @accommodation.build_property_policy Factory.attributes_for(:property_policy)
  end

  it 'allows save if valid' do
    @accommodation.save.should be_true
  end

  describe 'defaults' do

    it 'defaults "infant age from" to 0' do
      @property_policy.infant_age_from.should be_zero
    end

    it 'defaults "infant age to" to 2' do
      @property_policy.infant_age_to.should == 2
    end

    it 'defaults "children age from" to 2' do
      @property_policy.children_age_from.should == 2
    end

    it 'defaults "children age from" to 12' do
      @property_policy.children_age_to.should == 12
    end

  end

  describe 'validations' do

    context 'child policy' do

      [:infant_age_from, :infant_age_to, :children_age_from, :children_age_to].each do |a|

        context "'#{a.to_s.humanize.downcase}'" do

          (0..18).each do |i|
            it "should accept #{i} as a valid value" do
              @property_policy.send(:"#{a}=", i)

              # These two fields' values are tied together.
              @property_policy.children_age_from = i if a == :infant_age_to
              @property_policy.infant_age_to     = i if a == :children_age_from

              @accommodation.should be_valid
            end
          end

          [-1, 19, 42].each do |i|
            it "should not accept #{i} as a valid value" do
              @property_policy.send(:"#{a}=", i)
              @accommodation.should_not be_valid
            end
          end

          it "should not accept a non-number" do
            @property_policy.send(:"#{a}=", 'invalid')
            @accommodation.should_not be_valid
          end

        end

      end

      it "requires 'infant age to' to be <= 'child age from'" do
        @property_policy.infant_age_to = 2
        @property_policy.children_age_from = 1
        @accommodation.should_not be_valid

        @property_policy.children_age_from = 2
        @accommodation.should be_valid

        @property_policy.children_age_from = 3
        @accommodation.should be_valid
      end

    end

    context 'family policy' do

      it 'adults included must be a number' do
        @property_policy.adults_included = 'abc'
        @accommodation.should_not be_valid
      end

      it 'children included must be a number' do
        @property_policy.children_included = 'abc'
        @accommodation.should_not be_valid
      end

      it 'adults needed must be a number' do
        @property_policy.adults_needed = 'abc'
        @accommodation.should_not be_valid
      end

      it 'adults included must be a positive number' do
        @property_policy.adults_included = -1
        @accommodation.should_not be_valid
      end

      it 'children included must be a positive number' do
        @property_policy.children_included = -2
        @accommodation.should_not be_valid
      end

      it 'adults needed must be a positive number' do
        @property_policy.adults_needed = -3
        @accommodation.should_not be_valid
      end

    end

    context 'cancelation policy' do

      it 'amount must be a number' do
        @property_policy.fee_amount = 'abc'
        @property_policy.should_not be_valid
      end

      it 'time before usage must be a number' do
        @property_policy.time_before_usage = 'abc'
        @property_policy.should_not be_valid
      end

    end

    context 'group policy' do

      it 'group policy has max character limit of 1000' do
        @property_policy.group_policy = 'a' * 1001
        @property_policy.should_not be_valid
      end

    end

  end
end
