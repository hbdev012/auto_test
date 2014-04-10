class Admin::NonAccommodationProductsController < Admin::SupplierBaseController
  default_assumption :restful_rails

  assume(:non_accommodations) { current_company.properties.where(:_type => 'NonAccommodation') }
  assume(:non_accommodation_products) do
    if params[:pid].present?
      NonAccommodationProduct.where(:supplier_id => current_company.id).where(:property_id => params[:pid])
    else
      NonAccommodationProduct.where(:supplier_id => current_company.id)
    end
  end
  assume(:non_accommodation_product) do
    if ['new', 'create'].include?(params[:action])
      NonAccommodationProduct.new((params[:non_accommodation_product] || {}).merge(:supplier_id => current_company.id))
    else
      current_company.products.find(params[:id])
    end
  end

  before_filter :assign_default_step

  def index
  end

  def new
  end

  def edit
  end

  def create
    if non_accommodation_product.save
      redirect_to next_step, :notice => 'Non-Accommodation product was successfully created.'
    else
      render :action => 'new'
    end
  end

  def update
    non_accommodation_product.attributes = { 'inherited_bonus_offers' => [] }.merge(params[:non_accommodation_product] || {})

    if non_accommodation_product.save
      redirect_to next_step, :notice => 'Non-Accommodation product was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    flash[:alert] = "Non-accommodation product could not be deleted." unless non_accommodation_product.destroy
    redirect_to [:admin, :non_accommodation_products]
  end

private

  def assign_default_step
    params[:step] = 'basic_information' if params[:step].blank?
  end

  def next_step
    case params[:step]
      when 'basic_information'
        edit_admin_non_accommodation_product_url(non_accommodation_product, :step => 'tour_rates')
      when 'tour_rates'
        edit_admin_non_accommodation_product_url(non_accommodation_product, :step => 'tour_bonus')
      else
        root_url
    end
  end

end
