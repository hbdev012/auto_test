class CompanyTerm
  include Mongoid::Document

## Fields
  field :terms, :type => String

## Validations
  validates :terms, :presence => true
end
