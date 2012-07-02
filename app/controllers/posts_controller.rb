class PostsController < ApplicationController
  before_filter :authenticate_user!, :alert => 'You must be logged in to continue'
	load_and_authorize_resource
  impressionist :actions=>[:show] ##plugin to log pageviews

#  rescue_from NoMethodError, :with => :clear_preferences

	# GET /posts
  # GET /posts.xml

  def index

    #4chan style posts

    @post = Post.new
    @title = 'New Post'
    #end 4chan style

    @user = current_user
    @preference = current_preference
    if @preference.feed_preference == nil
      @preference.feed_preference = "trending value"
    end
      
    @title = @preference.feed_preference.capitalize
    
    @posts = Post
    unless @preference.tag_list == [] or @preference.tag_list == nil
      @posts = Post.tagged_with(@preference.tag_list)
    end
    
    if @preference.feed_preference == "trending value"
    @posts = @posts.order('trending_value DESC').page(params[:page]).per(5)
    
    elsif @preference.feed_preference == "time" 
    @posts = @posts.order('created_at DESC').page(params[:page]).per(5)

      elsif @preference.feed_preference == "humor"
     @posts = Post.tagged_with("humor")
    
    elsif @preference.feed_preference == "location" or @preference.feed_preference == "followers"
    @preference.feed_preference = "trending value"
    @posts = @posts.order('trending_value DESC').page(params[:page]).per(5)
    end  

#    @posts.each do |p| #may be inefficient
#      update_status_for_post(p)
#      p.save
#    end

    @preference.save

    #end of 4chan style posts

    respond_to do |format| #old code
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
    
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    #@posts = Post.order('trending_value DESC').page(params[:page]).per(5)
    @post = Post.find(params[:id])
    @user = current_user
    @comments = @post.comments
    #experimental
#    @comments = @post.children
    
    @title = @post.title  
      
    @comments.each do |c| #TODO: FIX
      update_status_comments(c)
      c.save
    end
    
    update_status
    
    @post.save

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @title = 'New Post'
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
    
  end

  # GET /posts/1/edit
  def edit
   @post = Post.find(params[:id])
   
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
    
  end
  
# def tag_with
#    @user = current_user
#    @user.tag_list << params[:tag]
#    
#    @user.save
#    
#   redirect_to '/posts'
#  end
#  
#  def clear_tag_list_and_preferences
#    @user = current_user
#    @user.tag_list.clear
#    @user.feed_preference = "trending value"
#    
#    @user.save
#    
#    redirect_to '/posts'
#  end
#  
#  def make_feed_preference
#    @user = current_user
#    @user.feed_preference = params[:preference]
#    
#    @user.save
#    
#    redirect_to '/posts'
#  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    #experimental
 #   @post = Post.create!(params[:post])
    @post.user = current_user
    @post.name = @post.user.name

    @post.pageviews = 0 
    @post.trending_value = 1
    
    @post.post_location = "Unavailable" if @post.post_location == ""
    @post.user_location = "Unavailable" if @post.user_location == ""
      
    @post.source = @post.user.name if @post.source == "" or 
    @post.source == "me" or @post.source == "Me"
    
    @post.tag_list = params[:tags]

    if @post.tag_list == []
      @post.tag_list << "Random"
    end

    alias_value = params[:alias_check]
    
    if (alias_value == 'true') or (@post.alias != nil and @post.alias != "")
      @post.is_anonymous = true
      
      if @post.alias == "anonymous" or @post.alias == ""
        @post.alias = "Anonymous"
      end
      
      @post.source = @post.alias if @post.source == "" or @post.source == "me" or @post.source == "Me"
      
    else
      @post.is_anonymous = false
    end
 
    @post.user.posts do |p|
      if @post.content == p.content
          @post.content = ""
          break p
      end
    end
        
    @post.save
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end

  end
  
#  def add_politics
#    @post.tag_list << 'politics'
#  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(:action=>'index')
    
#    respond_to do |format|
#      format.html { redirect_to(posts_url) }
#      format.xml  { head :ok }
#
#      format.js { redirect_to(posts_url) }
#    end
  end

  # Jon's vote code -- may be glitchy


  def update_status_for_post(p)
    p.pageviews = p.impressionist_count(:filter=>:session_hash)

    p.time_effective = p.created_at.to_time - Time.parse("20-08-2011 19:00") ##Times! in seconds!
    
#    p.total_votes = p.accuracy + p.inaccuracy
#
#    if p.total_votes == 0
#    p.accuracy_percent = 100
#    else
#    p.accuracy_percent = (100 * p.accuracy)/p.total_votes
#    end
#    # here is the amazing trending value algorithm
#    # TODO: pageview counter, time_effective counter
#
#    if p.total_votes == 0
#      tv = 1
#    elsif (Math.log(p.total_votes)<1)
#      tv=1
#    else
#      tv = Math.log(p.total_votes)
#    end
#
#    if p.pageviews == 0
#      pv = 1
#    elsif Math.log(p.pageviews)<1
#      pv=1
#    else
#      pv = Math.log(p.pageviews)
#    end
    
    #p.trending_value = tv*(p.accuracy_percent - 50) +
    #  10*pv + p.time_effective/4000


    if p.comments.empty?
      p.trending_value = p.time_effective
    end

  end

  def update_status
    update_status_for_post(@post)
    
    post_update_karma

  end


  def post_update_karma #this function updates the "value" received from a post

#    post_accuracy_ratio = 1
#
#    unless @post.inaccuracy == 0 and @post.accuracy == 0
#      post_accuracy_ratio = @post.accuracy_percent/100
#    end
#
#    #TODO: make sure our karma function doesn't crap out
#    @post.karma = 100*Math.log((@post.pageviews/10)*@post.accuracy*10 + 1) *
#      (post_accuracy_ratio - 0.4  ) +
#      (@post.accuracy/ 10)+
#      (Math.sqrt(@post.accuracy + @post.inaccuracy+400)) -
#      @post.inaccuracy/10 + 5
    
  end
  
  def update_status_comments(c)
#    c.relative_value = c.points_up - c.points_down + (rand() - 0.5)/10.0
#    c.save
  end
 
  
#
#def original_poster_update_karma #use this to work with the OP's karma
#  @post.user.karma = 0
#
#  @post.user.posts.each do |p| #TODO: double check this
#    if p.karma != nil
#    @post.user.karma += p.karma
#    else
#    p.karma = 0
#    end
#  end
#end
  
  end
