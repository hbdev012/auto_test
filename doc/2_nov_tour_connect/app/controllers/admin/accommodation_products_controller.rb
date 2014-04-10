class Admin::AccommodationProductsController < Admin::SupplierBaseController
  default_assumption :restful_rails

  assume(:accommodations) { current_company.properties.where(:_type => 'Accommodation') }
  assume(:accommodation_products) do
    if params[:pid].present?
      AccommodationProduct.where(:supplier_id => current_company.id).where(:property_id => params[:pid])
    else
      AccommodationProduct.where(:supplier_id => current_company.id)
    end
  end
  assume(:accommodation_product) do
    if ['new', 'create'].include?(params[:action])
      AccommodationProduct.new((params[:accommodation_product] || {}).merge(:supplier_id => current_company.id))
    else
      current_company.products.find(params[:id])
    end
  end

  before_filter :assign_default_step

  def index
  end

  def new
    accommodation_product.prepare_product
  end

  def edit
    accommodation_product.prepare_product
  end

  def create
    if accommodation_product.save
      redirect_to next_step, :notice => 'Accommodation product was successfully created.'
    else
      render :action => 'new'
    end
  end

  def update
    params[:accommodation_product]['room_detail']['amenities'] ||= [] if params[:accommodation_product]['room_detail'].present?
    accommodation_product.attributes = params[:accommodation_product]

    if accommodation_product.save
      redirect_to next_step, :notice => 'Accommodation product was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    flash[:alert] = "Accommodation product could not be deleted." unless accommodation_product.destroy
    redirect_to [:admin, :accommodation_products]
  end

private

  def assign_default_step
    params[:step] = 'basic_information' if params[:step].blank?
  end

  def next_step
    case params[:step]
      when 'basic_information'
        edit_admin_accommodation_product_url(accommodation_product, :step => 'room_details')
      when 'room_details'
        edit_admin_accommodation_product_url(accommodation_product, :step => 'room_rates')
      else
        root_url
    end
  end

end
