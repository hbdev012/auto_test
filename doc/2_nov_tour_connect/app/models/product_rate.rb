class ProductRate < ProductRateBase

## Associations
  embedded_in :product_rateable, :polymorphic => true

end
