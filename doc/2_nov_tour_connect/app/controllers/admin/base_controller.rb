class Admin::BaseController < AuthenticatedController
  before_filter :ensure_admin

private

  def ensure_admin
    authorize! :manage, :all
  end

  def ensure_contractor
    check_company!(Contractor)
  end

  def ensure_supplier
    check_company!(Supplier)
  end

  def check_company!(type)
    raise CanCan::AccessDenied.new("Access Denied: You are not authorized to take that action.") unless current_user.company.is_a?(type)
  end
end
