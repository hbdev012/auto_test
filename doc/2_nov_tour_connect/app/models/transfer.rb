class Transfer
  include Mongoid::Document

  belongs_to :accommodation

## Fields
  with_options :type => Integer do |transfer|
    transfer.field :adult_one_way_commission_amount
    transfer.field :adult_one_way_net_rate
    transfer.field :adult_return_commission_amount
    transfer.field :adult_return_net_rate
    transfer.field :child_one_way_commission_amount
    transfer.field :child_one_way_net_rate
    transfer.field :child_return_commission_amount
    transfer.field :child_return_net_rate
    transfer.field :max_passengers
  end

  with_options :type => Boolean, :default => false do |transfer|
    transfer.field :include_baby_seats
    transfer.field :provided_by_hotel
  end

  with_options :type => String do |transfer|
    transfer.field :adult_one_way_commission_type
    transfer.field :adult_return_commission_type
    transfer.field :child_one_way_commission_type
    transfer.field :child_return_commission_type
    transfer.field :from_location
    transfer.field :luggage_restrictions
    transfer.field :pick_up_details
    transfer.field :to_location
  end

## Validations
  with_options :numericality => { :greater_than_or_equal_to => 0 }, :allow_blank => true do |transfer|
    transfer.validates :adult_one_way_commission_amount
    transfer.validates :adult_one_way_net_rate
    transfer.validates :adult_return_commission_amount
    transfer.validates :adult_return_net_rate
    transfer.validates :child_one_way_commission_amount
    transfer.validates :child_one_way_net_rate
    transfer.validates :child_return_commission_amount
    transfer.validates :child_return_net_rate
    transfer.validates :max_passengers
  end

  with_options :inclusion => { :in => [true, false] } do |transfer|
    transfer.validates :include_baby_seats
    transfer.validates :provided_by_hotel
  end

end
