class Contact
  include Mongoid::Document

## Associations
  embedded_in :contact_group

## Fields
  with_options :type => String do |contact|
    contact.field :first_name
    contact.field :last_name
    contact.field :email
    contact.field :phone_number
    contact.field :fax_number
  end

## Validations
  with_options :presence => true do |contact|
    contact.validates :first_name
    contact.validates :last_name
    contact.validates :email
    contact.validates :phone_number
  end
end