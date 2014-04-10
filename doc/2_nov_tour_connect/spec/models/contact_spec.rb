require 'spec_helper'

describe Contact do

  before do
    @contact_group = Factory.build :contact_group
    @contact       = Factory.build :contact

    @contact_group.contacts << @contact
  end

  it 'should allow creation if valid' do
    @contact_group.save.should be_true
    @contact_group.contacts.first.should == @contact
  end

  describe 'validations' do

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
