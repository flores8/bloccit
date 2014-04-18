class FavoritesController < ApplicationController

	def create
		@topic = Topic.find(params[:topic_id])
		@post = @topic.posts.find(params[:post_id])
		favorite = current_user.favorites.build(post: @post)

		authorize favorite
		if favorite.save
			flash[:notice] = "Favorited Post"
			redirect_to [@topic, @post]
		else
			flash[:error] = "Unable to add favorite.  Please try again."
			redirect_to [@topic, @post]
		end
	end

	def destroy
		@topic = Topic.find(params[:topic_id])
		@post = @topic.posts.find(params[:post_id])
		favorite = current_user.favorites.find(params[:id])

		authorize favorite
		if favorite.destroy
			flash[:notice] = "Removed favorite."
			redirect_to [@topic, @post]
		else
			flash[:error] = "Unable to remove favorite. Please try again."
			redirect_to [@topic, @post]
		end
	end
end
