class BonusOffer < SpecialOffer

## Associations
  belongs_to  :bonus_offerable, :polymorphic => true
  embeds_many :bonus_offer_date_ranges, :as => :offerable, :class_name => 'SpecialOfferDateRange'

  accepts_nested_attributes_for :bonus_offer_date_ranges, :allow_destroy => true

## Fields
  with_options :type => String do |bonus_offer|
    bonus_offer.field :title
    bonus_offer.field :details
    bonus_offer.field :rate_type
    bonus_offer.field :rate
    bonus_offer.field :discount_type
  end

  with_options :type => Integer do |bonus_offer|
    bonus_offer.field :number_of_guests
    bonus_offer.field :max_number_of_guests
    bonus_offer.field :discount_amount
    bonus_offer.field :net_rate
    bonus_offer.field :commission_percent
  end

## Validations

  with_options :numericality => { :greater_than_or_equal_to => 0 }, :allow_blank => true do |bonus_offer|
    bonus_offer.validates :number_of_guests
    bonus_offer.validates :max_number_of_guests
    bonus_offer.validates :discount_amount
    bonus_offer.validates :net_rate
    bonus_offer.validates :commission_percent
  end

private

  # Override SpecialOffer method and super it.
  def nillify_fields
    if self.rate_type == "Per night"
      self.number_of_guests = self.max_number_of_guests = nil
    end

    if self.rate == "Rate Amount"
      self.discount_type = self.discount_amount = nil
    elsif self.rate == "Discount"
      self.net_rate = self.commission_percent = nil
    end

    super
  end

end
