class ConfirmationsController < Devise::ConfirmationsController

protected

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if resource.company_creator?
      edit_admin_signup_path
    else
      redirect_location(resource_name, resource)
    end
  end

end