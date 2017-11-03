class Relationship < ApplicationRecord
  belongs_to :request_user, class_name: "User"
  belongs_to :receive_user, class_name: "User"

  validates :request_user_id, presence: true
  validates :receive_user_id, presence: true
end
