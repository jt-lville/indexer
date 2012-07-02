class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.xml
  def create
    @post = Post.find(params[:post_id])
#		@comment = @post.comments.create(params[:comment])

    #@comment.content = params[:content]

    #TODO: perhaps add an if statement here to sort it only into post.comments if there's no parent comment?
    @comment = @post.comments.new(params[:comment])

		@comment.name = current_user.name
    #Jon added
    @comment.user = current_user
    @comment.relative_value = 0

    @comment.is_saged = (params[:sage_check] == 'true')
    alias_value = params[:alias_check]

    if (alias_value == 'true') or (@comment.alias != nil and @comment.alias != "")
      @comment.is_anonymous = true

      if @comment.alias == "anonymous" or @comment.alias == ""
        @comment.alias = "Anonymous"
      end
    else
      @comment.is_anonymous = false
    
    end
    
    @comment.points_up = 0
    @comment.points_down = 0

    unless @comment.is_saged
    @post.trending_value = Time.now.to_time - Time.parse("20-08-2011 19:00")
    end

    @post.save
    @comment.save
		
		redirect_to post_path(@post)
	end

  def new
     @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  def show
    @comments = Comment.order('relative_value DESC').page(params[:page]).per(25)
    @comment = Comment.find(params[:id])

    @post = @comment.post
    @user = current_user

    update_status

    @comment.save
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
    
  end
  
  def edit
    
  end

  def update #reply has been moved here experimentally
     #parent_comment = params[:parent_comment]
     parent_comment = Comment.find(params[:id])
#    nested_comment = Comment.create!(:name => 'Nested comment')
    nested_comment = Comment.create!(:content => params[:content], :user => current_user, :name => current_user.name)

    nested_comment.user = current_user
    nested_comment.name = current_user.name
    nested_comment.relative_value = 0
    nested_comment.points_up = 0
    nested_comment.points_down = 0
    nested_comment.save

    nested_comment.move_to_child_of(parent_comment)
#    parents_comment.save
    parent_comment.reload

    nested_comment
    
  end

  def reply
#    parent_comment = params[:parent_comment]
##    nested_comment = Comment.create!(:name => 'Nested comment')
#    nested_comment = Comment.create!(params[:comment])
#    nested_comment.move_to_child_of(parent_comment)
#    parent_comment.reload
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to post_path(@post)
	end

  def vote_up
    @comment = Comment.find(params[:id])
    @post = @comment.post
    
    @comment.points_up += 1
    
    update_status
    
    if vote_changed?
    end
    
   @comment.save
   redirect_to post_path(@post) and return
   
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }

      format.js { redirect_to(posts_url) }
    end  

  end

  def vote_down
    
    @comment = Comment.find(params[:id])
    @post = @comment.post
    
   @comment.points_down += 1
    
   update_status
    
    if vote_changed?
    end
    
    @comment.save
    
    redirect_to post_path(@post) and return
    
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }

      format.js { redirect_to(posts_url) }
    end  

  end

  def vote_changed?
    
  end

  def update_status
    #@comment.relative_value = @comment.points_up - @comment.points_down + (rand() - 0.5)/10.0 #comment out for sschan
  end
  
#  def randomize! #this performs a random shuffle of comments with similar relative values
#    #ensures that all posts of equal value have an equal chance of being read
#    update_attributes(:relative_value => :relative_value + (rand() - 0.5)/10.0)
#    @comment.save
#  end

end