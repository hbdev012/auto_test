class Admin::AccommodationProductAmenitiesController < Admin::SupplierBaseController
  assume :accommodation_product

  respond_to :js

  def create

    render :head => :ok and return if accommodation_product.room_detail.amenities.include?(params['name']) || params['name'].blank?

    accommodation_product.room_detail.amenities << params['name']

    accommodation_product.save
  end

end