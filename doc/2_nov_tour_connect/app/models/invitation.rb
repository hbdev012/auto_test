require 'csv'

class Invitation
  include Mongoid::Document
  include Mongoid::Timestamps

## Relations
  belongs_to :user

## Fields
  with_options :type => String do |invitation|
    invitation.field :company_name
    invitation.field :email
    invitation.field :first_name
    invitation.field :last_name
    invitation.field :group_id
    invitation.field :status, :default => 'unprocessed'
  end

## Validations
  with_options :presence => true do |invitation|
    invitation.validates :company_name
    invitation.validates :email
  end

  validate :unique_email

## Callbacks

## Class Methods

  def self.process_csv file, userid
    groupid = Digest::MD5.hexdigest("#{ Time.now } #{ userid }")

    CSV.foreach(file) do |row|
      invitation = Invitation.new :company_name => row[0],
                                  :email        => row[1],
                                  :first_name   => row[2],
                                  :last_name    => row[3],
                                  :user_id      => userid,
                                  :group_id     => groupid

      invitation.save(:validate => false)
    end

  end

  def self.deliver_unsent_invitations
    invitation_groups = Invitation.where(:status => 'unprocessed').group_by(&:group_id)

    invitation_groups.each do |group_id, invitations|
      invitations.each do |inv|
        if inv.company_name.blank? || inv.email.blank?
          inv.update_attribute(:status, 'invalid')
        elsif User.where(:email => inv.email).present? || Invitation.where(:email => inv.email, :status => 'invited').present?
          inv.update_attribute(:status, 'already invited')
        else
          begin
            InvitationMailer.invitation(inv).deliver
            inv.update_attribute(:status, 'invited')
          rescue
            inv.update_attribute(:status, 'failed')
          end
        end
      end

      Invitation.deliver_status_email(invitations) unless group_id.nil?
    end
  end

## Instance Methods
  def name
    [self.first_name, self.last_name].compact.join(' ')
  end

private

  def unique_email
    self.errors.add(:email, 'is invalid - A user already exists with that email address') if User.where(:email => self.email).present?
    self.errors.add(:email, 'is invalid - An invitation has already been sent to that email') if Invitation.where(:email => self.email, :status => 'invited').present?
  end

  def self.deliver_status_email(invitations)
    FileUtils.mkdir('tmp') unless Dir.exists?('tmp')
    file_path = Rails.root.join('tmp', 'invite_list_status.csv')
    File.open(file_path, 'w') do |file|
      invitations.each do |inv|
        file << [inv.company_name, inv.email, inv.first_name, inv.last_name, inv.status].to_csv
      end
    end

    InvitationMailer.status(invitations.first.user, file_path, invitations).deliver
  end

end
