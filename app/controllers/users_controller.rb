class UsersController < ApplicationController 
  before_filter :authenticate_user!, :alert => 'You must be logged in to continue'
  
  #has_many :following, :through => :relationships, :source => "followed_id"
	
  def show
		@user_on_page = User.find(params[:id])
    @user = current_user
    @posts = @user_on_page.posts.page(params[:page]).per(5) #Post.find(params[:user]).page(params[:page]).per(5) #TODO
    @comments = @user_on_page.comments.page(params[:page]).per(10)
      
    @title = @user_on_page.name
    
    #@user_on_page.karma = 0 if @user.karma == nil
    
    @user_on_page.karma = 0
    @user_on_page.reliability = 0
    #@user_on_page.accuracy = 0
    #@user_on_page.inaccuracy = 0
    
    @user_on_page.accuracy = 0
    @user_on_page.inaccuracy = 0

    #@user_on_page.posts.each do |p| #working
     # if p.karma != nil
      #@user_on_page.karma += p.karma
      #else
      #p.karma = 0
      #end
      
      #@user_on_page.accuracy += p.accuracy
      #@user_on_page.inaccuracy += p.inaccuracy
      
      #end
      
    if @user_on_page.accuracy + @user_on_page.inaccuracy == 0    
    @user_on_page.reliability = 100     #default reliability
    else
    @user_on_page.reliability = (@user_on_page.accuracy/(@user_on_page.accuracy + @user_on_page.inaccuracy))*100
    end
    
#  @user_on_page.comments.each do |c| #TODO: double check this
#      if c.karma != nil
#      @user_on_page.karma += c.karma
#      else
#      c.karma = 0
#      end
#  end

    @user_on_page.save
    
	end
  
end
