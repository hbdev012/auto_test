class ContactGroup
  include Mongoid::Document
  include Mongoid::Timestamps

## Associations
  belongs_to  :contact_groupable, :polymorphic => true
  embeds_many :contacts

  accepts_nested_attributes_for :contacts, :allow_destroy => true

## Scopes
  scope :admin_group,   where(:admin_group => true)
  scope :initial_group, where(:initial_group => true)

## Fields
  with_options :type => Boolean, :default => false do |contact_group|
    contact_group.field :admin_group
    contact_group.field :initial_group
  end
  field :name, :type => String

## Validations
  validates :name, :presence => true
end

