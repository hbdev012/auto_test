class InvitationMailer < ActionMailer::Base
  default from: "support@tourconnect.com"

  def invitation(invitation)
    @invitation = invitation
    @url        = new_user_registration_url(:invitation_id => invitation.id)

    mail :to => invitation.email, :subject => 'Invitation to join TourConnect'
  end

  def status user, file_path, invitations
    @processed_count       = invitations.count
    @invited_count         = invitations.select{ |i| i.status == 'invited' }.count
    @already_invited_count = invitations.select{ |i| i.status == 'already invited' }.count
    @invalid_count         = invitations.select{ |i| i.status == 'invalid' }.count
    @failed_count          = invitations.select{ |i| i.status == 'failed' }.count

    attachments['invite_list_status.csv'] = File.read(file_path)

    mail :to          => user.email,
         :subject     => "Invitation Summary: #{ @processed_count } invitations processed"
  end

end
