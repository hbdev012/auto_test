class SpecialOfferDateRange
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

## Associations
  embedded_in :offerable, :polymorphic => true

## Fields
  field :from, :type => Date
  field :to,   :type => Date

end
