class Contractor < Company

## Associations
  embeds_many :contractor_terms

## Nested Attributes
  accepts_nested_attributes_for :contractor_terms, :allow_destroy => true

end
