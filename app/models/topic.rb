class Topic < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	scope :visible_to, ->(user) { user ? scoped : where(public: true) }
end
