class SupplierCorporateInformation
  include Mongoid::Document

## Associations
  embedded_in :supplier

## Constants
  PRODUCT_TYPES = %w(Accommodation Non-Accommodation Rental).freeze

## Fields
  field :direct_products, :type => Boolean
  field :product_type,    :type => String

## Validations
  validates :product_type,    :inclusion => PRODUCT_TYPES
  validates :direct_products, :inclusion => { :in => [true, false] }

end
