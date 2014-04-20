class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Relationships
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  # Top Rated User
  def self.top_rated
    self.select('users.*'). # Select all attributes of the user
      select('COUNT(DISTINCT comments.id) AS comments_count'). # Count the comments made by the user
      select('COUNT(DISTINCT posts.id) AS posts_count'). # count the posts made by the user
      select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). # Add the comment count to the post count and label the sum as "rank"
      joins(:posts). # Ties the posts table to teh users table, via the user_id
      joins(:comments). # Ties the comments table to the users table, via the user_id
      group('users.id'). # Instrucst the database to group the results so that each user will be returned in a distinct row
      order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query (rank = comment count + post count)
  end

  ROLES = %w[member moderator admin]

  def role?(base_role)
  	role == base_role.to_s
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end
end
