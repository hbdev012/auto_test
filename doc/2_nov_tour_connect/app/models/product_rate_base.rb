class ProductRateBase
  include Mongoid::Document

## Associations
  embeds_one  :price_info, :as => :priceable

## Fields
  field :description, :type => String
end
