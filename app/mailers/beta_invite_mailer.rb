class BetaInviteMailer < ActionMailer::Base
  #default :from => "info@orchive.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.beta_invite_mailer.send_beta_invite.subject
  #
  def send_beta_invite(send_to)
    #@greeting = "Hi"
    
    subject     'Orchive Beta Invite'
    recipients  send_to
    from        'info@orchive.com'
    sent_on     Time.now
    
    #mail :to => send_to
  end
end
