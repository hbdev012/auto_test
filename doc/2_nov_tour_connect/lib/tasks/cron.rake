desc "This task is called by the Heroku cron add-on"

task :cron => :environment do
  Invitation.deliver_unsent_invitations
end
