class InvitationsController < AuthenticatedController
  assume(:invitation) { Invitation.new (params[:invitation] || {}).merge(:user_id => current_user.id) }

  def new
  end

  def create
    if params[:invitation][:invite_list]
      Invitation.process_csv(params[:invitation][:invite_list].tempfile, current_user.id)
      redirect_to root_url, :notice => 'Processing invitations, you will receive a status notification email upon completion' and return
    end

    if invitation.save
      redirect_to root_url, :notice => 'Invitation sent.'
    else
      render :new
    end
  end

end
