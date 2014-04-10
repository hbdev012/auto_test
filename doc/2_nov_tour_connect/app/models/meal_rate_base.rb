class MealRateBase
  include Mongoid::Document

## Fields
  with_options :type => String do |meal_rate|
    meal_rate.field :name
    meal_rate.field :ad_rate
    meal_rate.field :ch_rate
    meal_rate.field :description
  end

end
