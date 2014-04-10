class PropertyPolicy
  include Mongoid::Document

## Associations
  embedded_in :property

## Fields
  with_options :type => Integer do |property_policy|
    property_policy.field :adults_included
    property_policy.field :adults_needed
    property_policy.field :children_age_from, :default => 2
    property_policy.field :children_age_to,   :default => 12
    property_policy.field :children_included
    property_policy.field :infant_age_from,   :default => 0
    property_policy.field :infant_age_to,     :default => 2
    property_policy.field :time_before_usage
  end

  field :fee_amount,   :type => Float
  field :fee_type,     :type => String
  field :group_policy, :type => String

## Validations

  with_options :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 18 } do |property_policy|
    property_policy.validates :children_age_from
    property_policy.validates :children_age_to
    property_policy.validates :infant_age_from
  end
  validates :infant_age_to, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Proc.new { |ap| ap.children_age_from.to_i } }

  with_options :numericality => { :only_integer => true, :allow_blank => true, :greater_than_or_equal_to => 0 } do |property_policy|
    property_policy.validates :adults_included
    property_policy.validates :adults_needed
    property_policy.validates :children_included
    property_policy.validates :time_before_usage
  end

  validates :group_policy, :length       => { :maximum => 1000 }
  validates :fee_amount,   :numericality => { :allow_blank => true, :greater_than_or_equal_to => 0 }
end
