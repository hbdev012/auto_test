require 'spec_helper'

describe ContactGroup do

  before do
    @contact_group = Factory.build :contact_group
  end

  it 'should allow creation if valid' do
    @contact_group.save.should be_true
  end

  describe 'validations' do

    it 'should require a name' do
      @contact_group.name = ''
      @contact_group.should_not be_valid
    end

  end

  describe 'contacts' do

    it 'should allow contacts to be created through nested attributes' do
      contact = Factory.build :contact
      @contact_group.attributes = { 'contacts_attributes' => { '0' => contact.attributes.except('_id') } }
      @contact_group.save!

      group = ContactGroup.find(@contact_group.id)
      group.contacts.should be_present

      first_contact = group.contacts.last
      first_contact.first_name.should   == contact.first_name
      first_contact.last_name.should    == contact.last_name
      first_contact.email.should        == contact.email
      first_contact.phone_number.should == contact.phone_number
      first_contact.fax_number.should   == contact.fax_number
    end

  end

  describe 'contact validations' do

    before do
      @contact = @contact_group.contacts.build
    end

    it 'should require a first name' do
      @contact.first_name = ''
      @contact.should_not be_valid
    end

    it 'should require a last name' do
      @contact.last_name = ''
      @contact.should_not be_valid
    end

    it 'should require a email' do
      @contact.email = ''
      @contact.should_not be_valid
    end

    it 'should require a phone number' do
      @contact.phone_number = ''
      @contact.should_not be_valid
    end

  end


end
