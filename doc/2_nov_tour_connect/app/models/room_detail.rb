class RoomDetail
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

## Associations
  embedded_in :accommodation_product

## Fields
  with_options :type => Time do |room_detail|
    room_detail.field :check_in_at
    room_detail.field :check_out_at
    room_detail.field :late_check_out_at
  end

  with_options :type => Boolean do |room_detail|
    room_detail.field :late_check_out
    room_detail.field :consider_as_existing_bedding
    room_detail.field :interconnecting_rooms
  end

  with_options :type => String do |room_detail|
    room_detail.field :late_check_out_cost
    room_detail.field :room_classification
    room_detail.field :maximum_pax_adult_child
    room_detail.field :existing_bedding
  end

  with_options :type => Integer do |room_detail|
    room_detail.field :maximum_pax_adults
    room_detail.field :sofas
    room_detail.field :rollaways
  end

  field :amenities, :type => Array, :default => []

## Callbacks
  before_validation :nillify_fields

private

  def nillify_fields
    unless self.late_check_out?
      self.late_check_out_at   = nil
      self.late_check_out_cost = nil
    end
  end
end
