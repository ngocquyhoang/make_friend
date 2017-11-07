require 'unicode_utils'

class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  
  mount_uploader :avatar, User::AvatarUploader

  before_save :clean_username
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :username, uniqueness: true, length: { in: 6..20 }, format: { with: VALID_USERNAME_REGEX }, allow_blank: true

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

  def refused_request( other_user )
    receives.delete( other_user )
  end

  def is_friend?( other_user )
    self.in_relation( other_user, true ) || other_user.in_relation( self, true )
  end

  def in_relation( other_user, accept_param )
    relation = Relationship.where( request_user_id: self.id, receive_user_id: other_user.id ).take

    if relation.blank?
      return false
    else
      return ( requesting.include?( other_user ) && ( relation.is_accept == accept_param ) ) ? true : false
    end
  end

  def clean_username
    self.username = UnicodeUtils.downcase("#{self.username}", :tr).gsub(/[()-,. @*&$#^!']/, '')
  end

  def add_point( point )
    self.trust_point += point
    self.save
  end

  def get_age
    if self.dob.nil?
      return 0
    else
      now = Time.now
      age = now.year - self.dob.year - ( self.dob.to_time.change(:year => now.year) > now ? 1 : 0 )
      return age
    end
  end

  def match_point( other_user )
    mp = 0
    mp += 10 if ( self.get_age - other_user.get_age ).abs <= 5 

    if self.address_province == other_user.address_province
      mp += 15
      if self.address_district == other_user.address_district
        mp += 30
        mp += 45 if self.address_commune == other_user.address_commune
      end
    end

    if self.highschool_province == other_user.highschool_province
      mp += 15
      if self.highschool_district == other_user.highschool_district
        mp += 30
        mp += 45 if self.high_school == other_user.high_school
      end
    end

    mp += 45 if self.univesity == other_user.univesity
    
    if self.job.present? && other_user.job.present?
      self.job.split("|").each do |job|
        mp += 30 if other_user.job.split("|").include?(job)
      end
    end
    
    if self.hobby.present? && other_user.hobby.present?
      self.hobby.split("|").each do |hobby|
        mp += 20 if other_user.hobby.split("|").include?(hobby)
        mp += -20 if other_user.dislike.split("|").include?(hobby)
      end
    end

    if self.dislike.present? && other_user.dislike.present?
      self.dislike.split("|").each do |dislike|
        mp += 15 if other_user.dislike.split("|").include?(dislike)
        mp += -20 if other_user.hobby.split("|").include?(dislike)
      end
    end

    return mp
  end
end
