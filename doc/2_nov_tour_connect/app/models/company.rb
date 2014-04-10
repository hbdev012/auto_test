class Company
  include Mongoid::Document
  include Mongoid::Timestamps

## Associations
  belongs_to :creator, :class_name => 'User'

  with_options :dependent => :destroy, :autosave => true do |company|
    company.has_many :contact_groups, :as => :contact_groupable, :order => [[:admin_group, :desc], [:initial_group, :desc], [:name, :asc]]
    company.has_many :corporate_locations
    company.has_many :users
  end

  embeds_one :billing_information, :as => :billable
  embeds_one :corporate_information

## Nested Attributes
  accepts_nested_attributes_for :users

  with_options :allow_destroy => true do |company|
    company.accepts_nested_attributes_for :contact_groups
    company.accepts_nested_attributes_for :corporate_locations
  end

## Constants
  DEFAULT_CONTACT_GROUPS = %w(Administrator Sales Billing Reservations).freeze
  CURRENCIES             = ['United States Dollar', 'Australian Dollar'].freeze

## Fields
  field :country,          :type => String
  field :currency,         :type => String
  field :name,             :type => String
  field :pending_user_ids, :type => Array, :default => []

## Validations
  with_options :presence => true do |company|
    company.validates :_type
    company.validates :country
    company.validates :name, :uniqueness => { :case_sensitive => false, :scope => [:country, :_type] }
  end

## Callbacks
  after_create :create_defaults

## Instance Methods
  def accept_pending_user!(user)
    if self.pending_user_ids.delete(user.id) and self.save(:validate => false)
      user.send_confirmation_instructions
    end
  end

  def assign_creator!(user)
    # Creator must be a member of this company
    if self.users.include?(user) and !self.has_pending_user?(user)
      self.creator = user
      assign_creator_to_admin_group!
      self.save(:validate => false)
    else
      raise "Creator cannot be assigned; they must be a member of this company."
    end
  end

  def has_pending_user!(user)
    unless has_pending_user?(user)
      self.pending_user_ids << user.id
      self.save(:validate => false)
      UserMailer.request_to_join_company(user, self).deliver unless self.creator.nil?
    end
  end

  def as_json(options = {})
    {
      _id:           self.id,
      name:          self.name,
      country:       self.country,
      creator_name:  self.creator.name,
      creator_email: self.creator.email
    }
  end

  def prepare_company
    initialize_dependencies
  end

  def reject_pending_user! user, reason=nil
    if self.pending_user_ids.delete(user.id) and self.save(:validate => false)
      UserMailer.rejection_email(user, self, reason).deliver
      user.destroy
    end
  end

  def has_pending_user?(user)
    self.pending_user_ids.include?(user.id)
  end

  def pending_user(id)
    bson_id = id.is_a?(BSON::ObjectId) ? id : BSON::ObjectId(id)
    self.users.find(id) if self.pending_user_ids.include?(bson_id)
  end

  def pending_users
    self.users.find(self.pending_user_ids)
  end

private

  def assign_creator_to_admin_group!
    admin_group   = self.contact_groups.where(:admin_group => true).first
    admin_contact = admin_group.contacts.first || admin_group.contacts.build

    admin_contact.first_name = self.creator.first_name
    admin_contact.last_name  = self.creator.last_name
    admin_contact.email      = self.creator.email

    admin_group.save(:validate => false)
  end

  def initialize_dependencies
    self.build_corporate_information if self.corporate_information.nil?
    self.corporate_locations.build if self.corporate_locations.empty?
    self.contact_groups.each { |cg| cg.contacts.build if cg.contacts.empty? }
  end

  def create_defaults
    DEFAULT_CONTACT_GROUPS.each do |group|
      default_group = self.contact_groups.create! :name => group, :initial_group => true, :admin_group => (group == 'Administrator')
    end
  end

end
