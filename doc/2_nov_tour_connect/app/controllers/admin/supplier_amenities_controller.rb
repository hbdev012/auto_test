class Admin::SupplierAmenitiesController < Admin::SupplierBaseController
  assume :supplier

  respond_to :js

  def create

    render :head => :ok and return if supplier.amenities.include?(params['name']) || params['name'].blank?

    supplier.amenities << params['name']

    supplier.save
  end

end