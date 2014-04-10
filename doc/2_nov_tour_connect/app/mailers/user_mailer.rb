class UserMailer < ActionMailer::Base
  default from: "support@tourconnect.com"

  def request_to_join_company(user, company)
    @creator = company.creator
    @url     = root_url
    @user    = user

    mail :to => @creator.to_email_recipient, :subject => "#{user.name} requested to join your company"
  end

  def rejection_email user, company, reason=nil
    @user    = user
    @company = company
    @reason  = reason

    mail :to => @user.to_email_recipient, :subject => "Your request to join #{ @company.name } has been denied"
  end
end
