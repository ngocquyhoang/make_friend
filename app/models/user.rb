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

  has_many :active_relationships, class_name: "Relationship", foreign_key: "request_user_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "receive_user_id", dependent: :destroy
  has_many :requesting, through: :active_relationships, source: :receive_user
  has_many :receives, through: :passive_relationships, source: :request_user

  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end 

  def active_for_authentication?  
    super && !deleted_at  
  end 

  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end 

  def send_request( other_user )
    requesting <<  other_user 
  end

  def cancel_request( other_user )
    requesting.delete( other_user )
  end

  def accept_request( other_user )
    Relationship.where( request_user_id: other_user.id, receive_user_id: self.id ).take.update(:is_accept => true)
  end

  def cancel_friend( other_user )
    requesting.delete( other_user )
  end

  def is_friend?( other_user )
    self.in_relation( other_user ) || other_user.in_relation( self )
  end

  def in_relation( other_user )
    relation = Relationship.where( request_user_id: self.id, receive_user_id: other_user.id ).take

    if relation.blank?
      return false
    else
      return ( requesting.include?( other_user ) && relation.is_accept? ) ? true : false
    end
  end

  def clean_username
    self.username = UnicodeUtils.downcase("#{self.username}", :tr).gsub(/[()-,. @*&$#^!']/, '')
  end
end
