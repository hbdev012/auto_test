namespace :invitations do

  desc 'Processes unsent invitations'

  task :process do
    Invitation.deliver_unsent_invitations
  end

end