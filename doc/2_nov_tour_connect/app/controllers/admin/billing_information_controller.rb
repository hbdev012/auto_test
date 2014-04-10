class Admin::BillingInformationController < Admin::BaseController

  def edit
  end

  def update
    current_company.attributes = params[:company]

    if current_company.save
      redirect_to [:edit, :admin, :payment], :notice => 'Billing information added successfully.'
    else
      render :edit
    end
  end

end