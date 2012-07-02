class BetaInviteController < ApplicationController
  def index
  end

  def create
    BetaInviteMailer.deliver_send_beta_invite(send_to)
    flash[:notice] = 'Your message has been sent'
    #redirect_to WHERE DO I REDIRECT TO?
  end

end
