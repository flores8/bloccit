class Post < ActiveRecord::Base

	# Relationships
	belongs_to :user
	belongs_to :topic
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy

	mount_uploader :image, ImageUploader

	default_scope { order('created_at DESC') }

	# Validations
	validates :title, length: { minimum: 5 }, presence: true
	validates :body, length: { minimum: 20 }, presence: true
	validates :topic, presence: true
	validates :user, presence: true

	def up_votes
		self.votes.where(value: 1).count
	end

	def down_votes
		self.votes.where(value: -1).count
	end

	def points 
		self.votes.sum(:value).to_i
	end
end
