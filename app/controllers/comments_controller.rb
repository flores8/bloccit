class CommentsController < ApplicationController

  def create
  	binding.pry
  	@topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

  	@comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post

    authorize @comment
  	if @comment.save
  		flash[:notice] = "Comment was created successfully."
  	else
  		flash[:error] = "There was an error saving the comment. Please try again."
  	end

  	redirect_to [@topic, @post]
  end
end