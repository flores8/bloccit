class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
  	@post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
  	@post = current_user.posts.build(params.require(:post).permit(:title, :body))
    @post.topic = @topic

    authorize @post
  	if @post.save
  		redirect_to [@topic, @post], notice: "Post was saved successfully."
  	else
  		flash[:error] = "There was an error saving the post. Please try again."
  		render :new
  	end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:id])
    authorize @post
  	if @post.update_attributes(params.require(:post).permit(:title, :body))
  		flash[:notice] = "Post was updated."
  		redirect_to [@topic, @post]
  	else
  		flash[:error] = "There was an error saving the post.  Please try again."
  		render :edit
  	end
  end
end
