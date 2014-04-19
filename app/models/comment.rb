class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # Validations
	validates :body, length: { minimum: 5 }, presence: true

	after_create :send_favorite_emails

	private

	def send_favorite_emails
		# for every favorite associated with post, send email
		self.post.favorites.each do |favorite|
			# FavoriteMailer.new_comment(favorite.user, self.post, self).deliver unless favorite.user_id = self.user_id

			if favorite.user_id != self.user_id && favorite.user.email_favorites? 
				FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
			end
		end
	end
end
