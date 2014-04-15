class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # Validations
	validates :body, length: { minimum: 5 }, presence: true
end
