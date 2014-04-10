class NonAccommodationProduct < Product
  include Mongoid::MultiParameterAttributes

## Associations
  with_options :dependent => :destroy, :autosave => true do |non_accommodation_product|
    non_accommodation_product.has_many :bonus_offers, :as => :bonus_offerable
    non_accommodation_product.has_many :product_rate_groups
  end

  accepts_nested_attributes_for :bonus_offers, :allow_destroy => true
  accepts_nested_attributes_for :product_rate_groups, :allow_destroy => true

## Fields
  with_options :type => String do |product|
    product.field :duration_units
    product.field :pick_up_location
    product.field :drop_off_location
    product.field :standard_inclusion
    product.field :what_to_bring
  end

  with_options :type => Integer do |product|
    product.field :duration_value
    product.field :minimum_pax_adult
    product.field :minimum_pax_child
    product.field :minimum_pax_total
    product.field :maximum_pax_adult
    product.field :maximum_pax_child
    product.field :maximum_pax_total
  end

  with_options :type => Time do |product|
    product.field :pick_up_departs_at
    product.field :drop_off_departs_at
  end

  field :inherited_bonus_offers, :type => Array, :default => []

## Instance Methods
  def inherited_bonus_offers=(values=[])
    values.map! { |v| v.is_a?(BSON::ObjectId) ? v : BSON::ObjectId(v) }
    write_attribute(:inherited_bonus_offers, values)
  end

end

