class RegistrationsController < Devise::RegistrationsController

  assume(:company)
  assume(:user)

  def create
    build_resource

    if company.save
      if @existing_company
        # Make sure the user is "pending" within the company.
        company.has_pending_user!(user)
      else
        # Company creator becomes an admin and the creator of the company.
        user.has_role!(:admin)
        company.assign_creator!(user)
      end

      if is_navigational_format?
        set_flash_message :notice, :inactive_signed_up, :reason => I18n.t("devise.registrations.reasons.unconfirmed", :default => :unconfirmed)
        flash[:notice] += " #{I18n.t('devise.registrations.existing_company_sign_up')}" if @existing_company
      end

      expire_session_data_after_sign_in!
      respond_with company, :location => after_inactive_sign_up_path_for(company)
    else
      clean_up_passwords(user)
      respond_with_navigational(company) { render_with_scope :new }
    end
  end

  def update
    # Override Devise to use update_attributes instead of update_with_password.
    params[resource_name].delete(:password) if params[resource_name][:password].blank?
    params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank?

    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

protected

  def build_resource(hash=nil)
    if params[:invitation_id].present?
      invitation = Invitation.find(params[:invitation_id])

      params[:company] = {
        :name => invitation.company_name,
        :users_attributes => {
          '0' => {
            :email      => invitation.email,
            :first_name => invitation.first_name,
            :last_name  => invitation.last_name
          }
        }
      }
    end

    params[:company] ||= {}

    type  = params[:company].delete(:_type) || 'Supplier'
    id    = params[:company].delete(:id)
    klass = type.classify.constantize

    c = if id.present?
      klass.where(:_id => id).first
    else
      klass.where(:name => params[:company][:name], :country => params[:company][:country]).first
    end

    if c.nil?
      @existing_company = false
      self.company = klass.new(params[:company])
      if company.users.empty?
        self.user = company.users.build
      else
        self.user = company.users.first
      end
    else
      @existing_company = true
      self.company = c

      # Ignore any users except the first one.
      self.user    = company.users.build(params[:company][:users_attributes]['0'])
      user.skip_confirmation = true
    end
  end

end