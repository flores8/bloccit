class UsersController < ApplicationController
	before_filter :authenticate_user!

	def show 
		#binding.pry
		@user = User.find(params[:id])
		@posts = @user.posts.visible_to(current_user)
	end

	def update
		if current_user.update_attributes(user_params)
			flash[:notice] = "Your account information has been updated."
			redirect_to edit_user_registration_path(current_user)
		else
			render "devise/registrations/edit"
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :avatar, :avatar_cache, :email_favorites)
	end
end