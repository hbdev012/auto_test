class Admin::UsersController < Admin::BaseController

  assume(:users) { current_company.pending_users }
  assume(:user)  { current_company.pending_user(params[:id]) }

  respond_to :html
  respond_to :js, :only => :reject

  def index
  end

  def accept
    current_company.accept_pending_user!(user)
    redirect_to [:admin, :users], :notice => "#{user.name} is now a member of the company."
  end

  def reject
    current_company.reject_pending_user!(user, params[:reason])
    flash[:notice] = "#{user.name} has been removed."
    respond_with user, :location => [:admin, :users]
  end

end
