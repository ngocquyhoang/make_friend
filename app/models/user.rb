class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  mount_uploader :avatar, User::AvatarUploader
  
  validates :username, uniqueness: true, length: { in: 6..20 }

  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end 

  def active_for_authentication?  
    super && !deleted_at  
  end 

  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end 
end
