class InsuranceInformation
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

## Associations
  embedded_in :insurable, :polymorphic => true
  embeds_many :insurance_documents

  accepts_nested_attributes_for :insurance_documents, :allow_destroy => true

## Fields
  field :name,       :type => String
  field :expires_on, :type => Date

## Validations
  validates :expires_on, :presence => true

end
