class SpecialOffer
  include Mongoid::Document

## Callbacks
  before_validation :nillify_fields

## Fields
  field :combinable_allowed, :type => Boolean

  with_options :type => String do |special_offer|
    field :combined_offer
    field :booking_code
    field :special_conditions
  end

private

  def nillify_fields
    unless self.combinable_allowed
      self.combined_offer = nil
    end
  end

end
