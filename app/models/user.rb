class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Relationships
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :votes#, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def role?(base_role)
  	role == base_role.to_s
  end
end
