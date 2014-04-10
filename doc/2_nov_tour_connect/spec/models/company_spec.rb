require 'spec_helper'

describe Company do

  before do
    company = Factory.create :company

    user = Factory.create :user
    company.users << user
    company.assign_creator!(user)
    user.confirm!

    @company = Company.last
  end

  describe 'relations' do

    it 'should have many corporate locations' do
      @company.relations.should include("corporate_locations")
    end

    it 'should have billing information' do
      @company.relations['billing_information'].should be_present
    end

  end

  describe 'validations' do

    it 'should allow same name in different country' do
      company = Factory.build :company, :name => @company.name, :country => 'Australia'
      company.should be_valid
    end

    it 'should allow identical of a different type' do
      company = Factory.build :supplier, :name => @company.name, :country => @company.country
      company.should be_valid

      company = Factory.build :contractor, :name => @company.name, :country => @company.country
      company.should be_valid
    end

    it 'should require a name' do
      @company.name = ''
      @company.should_not be_valid
    end

    it 'should require a unique name within a country' do
      company = Factory.build :company, :name => @company.name
      company.should_not be_valid
    end

    it 'should require a case insensitive unique name within a country' do
      company = Factory.build :company, :name => @company.name.upcase
      company.should_not be_valid
    end

    it 'requires a country' do
      @company.country = ''
      @company.should_not be_valid
    end

    it 'should require a type' do
      @company._type = ''
      @company.should_not be_valid
    end

  end

  describe 'after_create' do

    Company::DEFAULT_CONTACT_GROUPS.each do |contact_group|
      it "should have #{contact_group}" do
        @company.contact_groups.where(:name => contact_group).should be_present
      end
    end

  end

  describe '#assign_creator!' do
    before do
      @company_no_creator = Factory.create :company
      @user               = Factory.create :user

      @company_no_creator.users << @user
    end

    it 'should assign a creator' do
      @company_no_creator.assign_creator!(@user)

      @company_no_creator.creator.should == @user
    end

    it 'cannot assign a user outside the company' do
      user = Factory.create :user
      lambda { @company_no_creator.assign_creator!(user) }.should raise_exception
    end

    it 'cannot assign a pending user' do
      @company_no_creator.has_pending_user!(@user)

      @company_no_creator.reload

      lambda { @company_no_creator.assign_creator!(@user) }.should raise_exception
    end

  end

  describe 'prepare_company' do

    before do
      @company.prepare_company
    end

    it 'should have corporate information' do
      @company.corporate_information.should be_present
    end

    it 'should have a corporate location' do
      @company.corporate_locations.should be_present
      @company.corporate_locations.first.should be_true
    end

  end

  describe 'contact_groups' do

    before do
      @company.attributes = {
        :product_type    => 'Accommodation',
        :direct_products => true,
        :description     => 'The company description'
      }
    end

    it 'should allow contact groups to be created through nested attributes' do
      contact_group = Factory.build :contact_group
      @company.attributes = { 'contact_groups_attributes' => { '0' => contact_group.attributes.except('_id') } }
      @company.save!

      company = Company.find(@company.id)
      company.contact_groups.should be_present

      first_contact_group = company.contact_groups.last
      first_contact_group.name.should == contact_group.name
    end

    # describe 'contacts' do
    # 
    #   it 'should allow contacts to be created through nested attributes' do
    #     contact_group = Factory.build :contact_group
    #     contact       = Factory.build :contact
    # 
    #     @company.update_attributes({ 'contact_groups_attributes' => { '0' => contact_group.attributes.except('_id').merge('contacts_attributes' => { '0' => contact.attributes.except('_id') }) } })
    # 
    #     # @company.update_attributes = { 'contact_groups_attributes' => { '0' => contact_group.attributes.except('_id').merge('contacts_attributes' => { '0' => contact.attributes.except('_id') }) } }
    #     # @company.save!
    # 
    #     company = Company.find(@company.id)
    #     group   = company.contact_groups.last
    #     group.contacts.should be_present
    # 
    #     first_contact = group.contacts.first
    #     first_contact.first_name.should   == contact.first_name
    #     first_contact.last_name.should    == contact.last_name
    #     first_contact.email.should        == contact.email
    #     first_contact.phone_number.should == contact.phone_number
    #     first_contact.fax_number.should   == contact.fax_number
    #   end
    # 
    # end

  end

  describe '#has_pending_user!' do

    before do
      @user = Factory.build :user
      @company.users << @user

      @company.reload
    end

    it 'should make the user a pending user' do
      @company.users.should have(2).entries
      @company.pending_user_ids.length.should be_zero

      @company.has_pending_user!(@user)
      @company.users.should have(2).entries
      @company.pending_user_ids.length.should == 1
      @company.pending_user_ids.should include(@user.id)
    end

    it 'should skip the user if they are already pending' do
      @company.has_pending_user!(@user)
      @company.has_pending_user!(@user)

      @company.users.should have(2).entries
      @company.pending_user_ids.length.should == 1
      @company.pending_user_ids.should include(@user.id)
    end

    it 'should send a request to join the company to the company creator' do
      email = UserMailer.request_to_join_company(@user, @company)

      UserMailer.should_receive(:request_to_join_company).and_return(email)
      email.should_receive(:deliver)

      @company.has_pending_user!(@user)
    end
  end

  describe '#has_pending_user?' do
    before do
      @company.users << Factory.build(:user)
      @pending = @company.users.last
      @company.has_pending_user!(@pending)

      @company.users << Factory.build(:user)
      @not_pending = @company.users.last
    end

    it 'should return true if user is pending' do
      @company.should have_pending_user(@pending)
    end

    it 'should return false if user is not pending' do
      @company.should_not have_pending_user(@not_pending)
    end
  end

  describe '#pending_users' do

    before do
      2.times { @company.users << Factory.build(:user) }
    end

    it 'should be empty if there are no pending users' do
      @company.pending_users.should be_empty
    end

    it 'should contain pending users' do
      @company.users.each { |u| @company.has_pending_user!(u) unless u.confirmed? }

      @company.reload

      @company.users.should have(3).entries
      @company.pending_users.should have(2).entries
    end

  end

  describe '#pending_user' do

    before do
      2.times { @company.users << Factory.build(:user) }
    end

    it 'should be nil if there is no pending user with the ID' do
      @company.pending_user(@company.creator.id).should be_nil
    end

    it 'should return the pending user' do
      @company.users.each { |u| @company.has_pending_user!(u) unless u.confirmed? }

      @company.reload

      @company.users.should have(3).entries
      user = @company.pending_user(@company.users.last.id)
      user.should_not be_nil
      @company.pending_user_ids.should include(user.id)
    end

  end

  describe '#accept_pending_user!' do

    before do
      @user = Factory.build(:user)
      @company.users << @user
      @company.has_pending_user!(@user)
    end

    it 'should remove the user from the pending users' do
      @company.accept_pending_user!(@user)
      Company.find(@company.id).pending_users.should have(0).entries
    end

    it 'should send the user confirmation email' do
      instructions = Devise::Mailer.confirmation_instructions(@user)

      Devise::Mailer.should_receive(:confirmation_instructions).with(@user).and_return(instructions)
      instructions.should_receive(:deliver)

      @company.accept_pending_user!(@user)
    end

  end

  describe '#reject_pending_user!' do

    before do
      @user = Factory.build(:user)
      @company.users << @user
      @company.has_pending_user!(@user)
    end

    it 'should remove the user from the pending users' do
      @company.reject_pending_user!(@user)
      Company.find(@company.id).pending_users.should have(0).entries
    end

    it 'should send the user confirmation email if there is no reason' do
      rejection_letter = UserMailer.rejection_email(@user, @company)

      UserMailer.should_receive(:rejection_email).and_return(rejection_letter)
      rejection_letter.should_receive(:deliver)

      @company.reject_pending_user!(@user)
    end

    it 'should send the user confirmation email if there is a reason' do
      @reason = 'You have been denied'
      rejection_letter = UserMailer.rejection_email(@user, @company, @reason)

      UserMailer.should_receive(:rejection_email).and_return(rejection_letter)
      rejection_letter.should_receive(:deliver)

      @company.reject_pending_user!(@user, @reason)
    end

    it 'should remove the user from the system' do
      @company.reject_pending_user!(@user)
      lambda { User.find(@user.id) }.should raise_exception(Mongoid::Errors::DocumentNotFound)
    end

  end

end
