class ProductMarket
  include Mongoid::Document

## Associations
  embedded_in :product_marketable, :polymorphic => true

## Fields
  with_options :type => Boolean, :default => false do |product_market|
    product_market.field :all_markets
    product_market.field :domestic_markets
    product_market.field :eta_markets
    product_market.field :inbound_markets
    product_market.field :other_markets
  end

  field :other_markets_value, :type => String

## Validations
  with_options :inclusion => { :in => [true, false] } do |product_rate_group|
    product_rate_group.validates :all_markets
    product_rate_group.validates :domestic_markets
    product_rate_group.validates :eta_markets
    product_rate_group.validates :inbound_markets
    product_rate_group.validates :other_markets
  end

end
