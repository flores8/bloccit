class Comment < ActiveRecord::Base
  belongs_to :post

  # Validations
	validates :body, length: { minimum: 5 }, presence: true
end
