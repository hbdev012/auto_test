class CorporateLocation < Location

## Associations
  belongs_to :company

## Fields
  field :corporate_identifier, :type => String

## Validations
  validates :corporate_identifier, :presence => true

end
