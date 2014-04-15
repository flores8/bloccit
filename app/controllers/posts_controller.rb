class PostsController < ApplicationController
  before_filter :authenticate_user! 

  def show
    #binding.pry
    @topic = Topic.find(params[:topic_id])
  	@post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.build
  end

  def new
    @topic = Topic.find(params[:topic_id])
  	@post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
  	@post = current_user.posts.build(post_params)
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
  	if @post.update_attributes(post_params)
  		flash[:notice] = "Post was updated."
  		redirect_to [@topic, @post]
  	else
  		flash[:error] = "There was an error saving the post.  Please try again."
  		render :edit
  	end
  end

  def destroy
    @topic = Topic.find(params(:topic_id))
    @post = Post.find(params(:id))

    title = @post.title
    authorize @post
    if @post.destroy 
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
