require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory.build :user
  end

  it "should create a new instance given valid attributes" do
    @user.save.should be_true
  end

  describe 'validations' do

    it 'should require a first name' do
      @user.first_name = ''
      @user.should_not be_valid
    end

    it 'should require a last name' do
      @user.last_name = ''
      @user.should_not be_valid
    end

    it 'requires acceptance of terms and conditions' do
      @user.terms = '0'
      @user.should_not be_valid
    end

    it 'should require a job title' do
      @user.job_title = ''
      @user.should_not be_valid
    end

    it 'should ensure role is known value' do
      @user.role = 'noexist'
      @user.should_not be_valid

      @user.role = 'admin'
      @user.should be_valid
    end

    it "should require an email address" do
      @user.email = ''
      @user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        @user.email = address
        @user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        @user.email = address
        @user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      @user.save!

      user = Factory.build :user, :email => @user.email
      user.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      @user.save!

      user = Factory.build :user, :email => @user.email.upcase
      user.should_not be_valid
    end

    it "should require a password" do
      @user.password = ''
      @user.should_not be_valid
    end

    it "should require a password confirmation" do
      @user.password_confirmation = ''
      @user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      @user.password_confirmation = 'invalid'
      @user.should_not be_valid
    end
    
    it "should reject short passwords" do
      @user.password = @user.password_confirmation = "a" * 5
      @user.should_not be_valid
    end

  end

  describe 'after_create' do

    it 'should send email confirmation' do
      instructions = Devise::Mailer.confirmation_instructions(@user)

      Devise::Mailer.should_receive(:confirmation_instructions).with(@user).and_return(instructions)
      instructions.should_receive(:deliver)

      @user.save!
    end

    it "should set the encrypted password attribute" do
      @user.save!
      @user.encrypted_password.should be_present
    end

  end

  describe '#has_role!' do

    before do
      @user.save!
      @user.has_role!(:admin)
    end

    it 'should assign the role' do
      @user.role.should == 'admin'
      User.find(@user.id).role.should == 'admin'
    end

    it 'should raise exception for bad role' do
      lambda { @user.has_role!(:invalid) }.should raise_exception
    end

  end

  describe '#name' do

    it 'should return the concatenation of the first and last names' do
      @user.name.should == "#{@user.first_name} #{@user.last_name}"
    end

  end

  describe '#to_email_recipient' do

    it 'should return the concatenation of the name and email address' do
      @user.to_email_recipient.should == "#{@user.name} <#{@user.email}>"
    end

  end

  describe '#company_creator?' do

    before do
      @company = Factory.create :supplier
      @creator = Factory.create :user
      @company.users << @creator
      @company.assign_creator!(@creator)
    end

    it 'returns true if user is the company creator' do
      @creator.should be_company_creator
    end

    it 'returns false if user is not the company creator' do
      user = Factory.build :user
      @company.users << user

      user.should_not be_company_creator
    end

  end

end