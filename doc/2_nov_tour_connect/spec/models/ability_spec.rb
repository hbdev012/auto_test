require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  before do
    company = Factory.create :company
    user    = Factory.create :user

    company.users << user
    company.assign_creator!(user)
    user.confirm!

    @user = User.last
  end

  describe 'admin' do

    before do
      @user.role = 'admin'
      @user.save!

      @ability = Ability.new(@user)
    end

    it 'should allow manage all' do
      @ability.should be_able_to(:manage, :all)
    end

  end

  describe 'non-admin' do

    before do
      @ability = Ability.new(@user)
    end

    it 'should allow read all' do
      @ability.should be_able_to(:read, :all)
      @ability.should_not be_able_to(:manage, :all)
    end

  end

end
