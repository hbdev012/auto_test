class Admin::NonAccommodationsController < Admin::SupplierBaseController
  default_assumption :restful_rails
  assume(:non_accommodations) { NonAccommodation.where(:supplier_id => current_company.id) }

  assume(:non_accommodation) do
    if ['new', 'create'].include?(params[:action])
      NonAccommodation.new((params[:non_accommodation] || {}).merge(:supplier_id => current_company.id))
    else
      current_company.properties.find(params[:id])
    end
  end

  before_filter :assign_default_step, :enforce_corporate_information

  def index
  end

  def new
    non_accommodation.prepare_property
  end

  def edit
    non_accommodation.prepare_property
  end

  def create
		if non_accommodation.save
      redirect_to next_step, :notice => 'Non-Accommodation was successfully created.'
    else
      non_accommodation.prepare_property
      render :action => 'new'
    end
  end

  def update
    non_accommodation.attributes = params[:non_accommodation]

    if non_accommodation.save
      redirect_to next_step, :notice => 'Non-Accommodation was successfully updated.'
    else
      non_accommodation.prepare_property
      render :action => 'edit'
    end
  end

  def destroy
    if non_accommodation.destroy
      redirect_to [:admin, :non_accommodations], :notice => 'Non Accommodation deleted'
    else
      redirect_to [:admin, :non_accommodations], :alert => 'Non Accommodation could not be deleted'
    end
  end

private

  def assign_default_step
    params[:step] = 'basic_information' if params[:step].blank?
  end

  # If the corporate information is being used, then remove the non_accommodations info.
  def enforce_corporate_information
    if params[:non_accommodation].present?
      [:billing_information, :insurance_information, :supplier_term].each do |corporate_info|
        if params[:non_accommodation]["use_corporate_#{ corporate_info }"] == '1'
          params[:non_accommodation].delete(corporate_info)

          # Only if we're changing to use corporate information.
          unless non_accommodation.send("use_corporate_#{ corporate_info }?")
            non_accommodation.send(corporate_info).destroy
          end
        end
      end
    end
  end

  def next_step
    case params[:step]
      when 'basic_information'
        edit_admin_non_accommodation_url(non_accommodation, :step => 'policies')
      when 'policies'
        edit_admin_non_accommodation_url(non_accommodation, :step => 'seasons')
      when 'seasons'
        if non_accommodation.has_season_gaps?
          edit_admin_non_accommodation_url(non_accommodation, :step => 'seasons')
        else
          edit_admin_non_accommodation_url(non_accommodation, :step => 'special_offers')
        end
      when 'special_offers'
        edit_admin_non_accommodation_url(non_accommodation, :step => 'contracts_and_billing')
      else
        root_url
    end
  end

end
