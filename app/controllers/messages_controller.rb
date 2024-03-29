class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = current_user.received_messages

    @messages.each do |m|
      m.unread = false
      m.save
    end

  end
  
  def create
    message = Message.new(params[:message])
    message.sender_id = current_user.id
    if message.save
      flash[:notice] = "you created a message"
      redirect_to '/posts'
      
    else
      @user = User.find(params[:message][:recipient_id])
      render :action => 'users/show'
    end

  end
  
end
