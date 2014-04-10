class AccommodationProduct < Product

## Associations
  embeds_one :room_detail
  has_many   :room_rates, :dependent => :destroy, :autosave => true

  accepts_nested_attributes_for :room_rates, :allow_destroy => true

## Fields
  with_options :type => String do |accommodation_product|
    accommodation_product.field :allocation_type
    accommodation_product.field :general_notes
  end

  with_options :type => Integer do |accommodation_product|
    accommodation_product.field :number_of_rooms
    accommodation_product.field :releaseback_days
  end

  field :complies_to_eu_regulations, :type => Boolean

## Validations
  with_options :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true } do |accommodation_prouct|
    accommodation_prouct.validates :number_of_rooms
    accommodation_prouct.validates :releaseback_days
  end

  before_validation :nillify_fields

  def prepare_product
    initialize_dependencies
  end

private

  def initialize_dependencies
    self.build_room_detail if self.room_detail.nil?
  end

  def nillify_fields
    unless self.allocation_type == 'allotment'
      self.number_of_rooms  = nil
      self.releaseback_days = nil
    end
  end

end
