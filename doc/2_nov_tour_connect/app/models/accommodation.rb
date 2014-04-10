class Accommodation < Property

## Associations
  with_options :dependent => :destroy, :autosave => true do |accommodation|
    accommodation.has_many :stay_pay_deals
    accommodation.has_many :room_upgrades
    accommodation.has_one  :transfer
  end

  with_options :allow_destroy => true do |accommodation|
    accommodation.accepts_nested_attributes_for :stay_pay_deals
    accommodation.accepts_nested_attributes_for :room_upgrades
    accommodation.accepts_nested_attributes_for :transfer
  end

## Constants
  CLASSIFICATIONS = ['Hotel', 'Lodge', 'Homestay/Farmstay', 'Resort', 'Caravan', 'Hostel', 'Apartments', 'Cottages', 'Motel', 'Bed & Breakfast']
  RATING_TYPES    = ['Official AAAT/Qualmark', 'Self assessed']

## Fields
  field :amenities,       :type => Array, :default => []
  field :classifications, :type => Array, :default => []
  field :rating,          :type => Integer
  field :rating_type,     :type => String

## Validations
  with_options :allow_nil => true do |accommodation|
    accommodation.validates :rating,      :numericality => true
    accommodation.validates :rating_type, :inclusion => RATING_TYPES
  end
  validate :valid_classifications

private

  def initialize_dependencies
    self.build_transfer unless self.transfer.present?
    super
  end

  def valid_classifications
    self.errors.add :classifications, 'are not valid' unless (self.classifications - CLASSIFICATIONS).empty?
  end

end
