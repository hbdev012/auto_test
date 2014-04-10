class Admin::AccommodationsController < Admin::SupplierBaseController
  default_assumption :restful_rails

  assume(:accommodations) { Accommodation.where(:supplier_id => current_company.id) }
  assume(:accommodation) do
    if ['new', 'create'].include?(params[:action])
      Accommodation.new((params[:accommodation] || {}).merge(:supplier_id => current_company.id))
    else
      current_company.properties.find(params[:id])
    end
  end

  before_filter :assign_default_step, :enforce_corporate_information

  def index
  end

  def new
    accommodation.prepare_property
  end

  def edit
    accommodation.prepare_property
  end

  def create
    if accommodation.save
      redirect_to next_step, :notice => 'Accommodation was successfully created.'
    else
      accommodation.prepare_property
      render :action => 'new'
    end
  end

  def update
    accommodation.attributes = { 'amenities' => [], 'classifications' => [] }.merge(params[:accommodation] || {})

    if accommodation.save
      redirect_to next_step, :notice => 'Accommodation was successfully updated.'
    else
      accommodation.prepare_property
      render :action => 'edit'
    end
  end

  def destroy
    if accommodation.destroy
      redirect_to [:admin, :accommodations], :notice => 'Accommodation deleted'
    else
      redirect_to [:admin, :accommodations], :alert => 'Accommodation could not be deleted'
    end
  end

private

  def assign_default_step
    params[:step] = 'basic_information' if params[:step].blank?
  end

  # If the corporate information is being used, then remove the accommodations info.
  def enforce_corporate_information
    if params[:accommodation].present?
      [:billing_information, :insurance_information, :supplier_term].each do |corporate_info|
        if params[:accommodation]["use_corporate_#{ corporate_info }"] == '1'
          params[:accommodation].delete(corporate_info)

          # Only if we're changing to use corporate information.
          unless accommodation.send("use_corporate_#{ corporate_info }?")
            accommodation.send(corporate_info).destroy
          end
        end
      end
    end
  end

  def next_step
    case params[:step]
      when 'basic_information'
        edit_admin_accommodation_url(accommodation, :step => 'ratings_and_amenities')
      when 'ratings_and_amenities'
        edit_admin_accommodation_url(accommodation, :step => 'policies')
      when 'policies'
        edit_admin_accommodation_url(accommodation, :step => 'seasons')
      when 'seasons'
        if accommodation.has_season_gaps?
          edit_admin_accommodation_url(accommodation, :step => 'seasons')
        else
          edit_admin_accommodation_url(accommodation, :step => 'special_offers')
        end
      when 'special_offers'
        edit_admin_accommodation_url(accommodation, :step => 'transfer')
      when 'transfer'
        edit_admin_accommodation_url(accommodation, :step => 'contracts_and_billing')
      else
        root_url
    end
  end

end
