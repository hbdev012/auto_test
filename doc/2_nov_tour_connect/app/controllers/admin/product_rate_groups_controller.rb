class Admin::ProductRateGroupsController < Admin::SupplierBaseController

  assume(:non_accommodation_product) { NonAccommodationProduct.find(params[:product_id]) }
  assume(:season)                    { non_accommodation_product.property.seasons.find(params[:season_id]) }
  assume(:product_rate_group)        { non_accommodation_product.product_rate_groups.build(:season => season) }

  def show
    product_rate_group.prepare_product_rate_group
    render :layout => false
  end

end