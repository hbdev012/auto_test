class Admin::TermsController < Admin::BaseController

  def edit
    current_company.contractor_terms.build if current_company.contractor_terms.empty?
  end

  def update
    current_company.attributes = params[:company]

    if current_company.save
      redirect_to [:edit, :admin, :payment], :notice => 'Terms and Submission Criteria saved successfully.'
    else
      render :edit
    end
  end

end