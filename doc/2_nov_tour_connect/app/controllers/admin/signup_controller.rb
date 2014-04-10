class Admin::SignupController < Admin::BaseController

  def edit
    current_company.prepare_company
  end

  def update
    current_company.attributes = params[:company]

    if current_company.save
      flash[:notice] = 'Corporate information saved successfully.'

      if current_company.is_a?(Supplier)
        redirect_to [:edit, :admin, :billing_information]
      else
        redirect_to [:edit, :admin, :terms]
      end
    else
      render :edit
    end
  end
end
