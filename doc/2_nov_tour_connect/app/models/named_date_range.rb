class NamedDateRange < SimpleDateRange

## Fields
  field :name, :type => String

## Validations
  validates :name, :presence => true

end
