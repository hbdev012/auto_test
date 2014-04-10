class SpecialEventMeal < MealRateBase

## Associations
  embedded_in :room_rate

## Fields
  field :mandatory, :type => Boolean
  field :date,      :type => String

end
