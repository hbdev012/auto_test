require 'spec_helper'

describe Invitation do
  
  before do
    @invitation = Factory.build :invitation
  end

  describe 'validations' do

    it 'should require company name' do
      @invitation.company_name = ''
      @invitation.should_not be_valid
    end

    describe 'email' do

      it 'requires email' do
        @invitation.email = ''
        @invitation.should_not be_valid
      end

      it 'must be unique amongst users' do
        Factory.create :user, :email => @invitation.email
        @invitation.should_not be_valid
      end

      it 'must be unique amongst invitations' do
        Factory.create :invitation, :email => @invitation.email, :status => 'invited'
        @invitation.should_not be_valid
      end

    end

  end

  describe '#name' do

    it 'should return first name only' do
      @invitation.first_name = 'Andrew'
      @invitation.name.should == "Andrew"
    end

    it 'should return last name only' do
      @invitation.last_name = 'Bowerman'
      @invitation.name.should == "Bowerman"
    end

    it 'should return first and last name only' do
      @invitation.first_name = 'Andrew'
      @invitation.last_name  = 'Bowerman'
      @invitation.name.should == "Andrew Bowerman"
    end

    it 'should return empty string' do
      @invitation.name.should be_empty
    end

  end

  describe '#process_csv' do

    before do
      @user = Factory.create :user
    end

    it 'creates new invitations for each row' do
      file = 'spec/data/invite_list.csv'
      Invitation.process_csv(file, @user.id)

      Invitation.count.should == 4
    end

  end

  describe '.deliver_unsent_invitations' do

    before do
      @user            = Factory.create :user
      @sent_invitation = Factory.create :invitation, :status => 'invited', :user => @user

    end

    it 'delivers all unsent single invitations' do
      @unsent_a = Factory.create :invitation, :user => @user, :company_name => 'unsent a', :email => 'unsent_a@test.com'
      @unsent_b = Factory.create :invitation, :user => @user, :company_name => 'unsent b', :email => 'unsent_b@test.com'

      inv_a = InvitationMailer.invitation(@unsent_a)
      inv_b = InvitationMailer.invitation(@unsent_b)
      InvitationMailer.should_receive(:invitation).with(@unsent_a).and_return(inv_a)
      InvitationMailer.should_receive(:invitation).with(@unsent_b).and_return(inv_b)
      inv_a.should_receive(:deliver)
      inv_b.should_receive(:deliver)

      InvitationMailer.should_not_receive(:invitation).with(@sent_invitation)
      Invitation.should_not_receive(:deliver_status_email)

      Invitation.deliver_unsent_invitations

      @unsent_a.reload.status.should_not == 'unprocessed'
      @unsent_b.reload.status.should_not == 'unprocessed'
    end

    it 'delivers all unsent bulk invitations' do
      @unsent_bulk_a = Factory.create :invitation, :user => @user, :company_name => 'unsent bulk a', :email => 'unsent_bulk_a@test.com', :group_id => 'ABC123'
      @unsent_bulk_b = Factory.create :invitation, :user => @user, :company_name => 'unsent bulk b', :email => 'unsent_bulk_b@test.com', :group_id => 'ABC123'

      inv_a = InvitationMailer.invitation(@unsent_bulk_a)
      inv_b = InvitationMailer.invitation(@unsent_bulk_b)
      InvitationMailer.should_receive(:invitation).with(@unsent_bulk_a).and_return(inv_a)
      InvitationMailer.should_receive(:invitation).with(@unsent_bulk_b).and_return(inv_b)
      inv_a.should_receive(:deliver)
      inv_b.should_receive(:deliver)

      InvitationMailer.should_not_receive(:invitation).with(@sent_invitation)
      Invitation.should_receive(:deliver_status_email)

      Invitation.deliver_unsent_invitations

      @unsent_bulk_a.reload.status.should_not == 'unprocessed'
      @unsent_bulk_b.reload.status.should_not == 'unprocessed'
    end


  end

end
