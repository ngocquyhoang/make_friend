require 'unicode_utils'

class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  
  mount_uploader :avatar, User::AvatarUploader

  before_save :clean_username
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :username, uniqueness: true, length: { in: 6..20 }, format: { with: VALID_USERNAME_REGEX }

  has_many :activities
  has_many :statuses
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end 

  def active_for_authentication?  
    super && !deleted_at  
  end 

  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end 

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def clean_username
    self.username = UnicodeUtils.downcase("#{self.username}", :tr).gsub(/[()-,. @*&$#^!']/, '')
  end
end
