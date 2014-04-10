class WeekendRate < ProductRateBase

## Associations
  embedded_in :weekend_rateable, :polymorphic => true

end
