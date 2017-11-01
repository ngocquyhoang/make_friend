require 'faker'
require 'unicode_utils'

Admin.create( email: 'admin@ngocquyhoang.com', password: '123456789', password_confirmation: '123456789' )

User.create( email: 'ngocquyhoang.93@gmail.com', username: 'ngocquyhoang', name: 'Hoang Ngoc Quy', gender: 'male', is_verified: true, password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
User.create( email: 'ngocquyhoang2911@gmail.com', username: 'ngocquyhoang2911', name: 'Hoang Ngoc Quy', gender: 'male', is_verified: false, password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )

(3..99).each do |index|
  case index%3
  when 2
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", gender: 'female', is_verified: Faker::Boolean.boolean(0.6), password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  when 1
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", gender: 'male', is_verified: Faker::Boolean.boolean(0.6), password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  when 0
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", is_verified: Faker::Boolean.boolean(0.6), password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  end
  Activity.create( user_id: index, activity_type: "update avatar" )
  Activity.create( user_id: index, activity_type: "update information" )
end

(2..60).each do |index|
  Relationship.create(follower_id: index, followed_id: 1)
  Activity.create( user_id: index, activity_type: "started following", activity_target: 1)
end

(50..80).each do |index|
  Relationship.create(follower_id: 1, followed_id: index)
  Activity.create( user_id: 1, activity_type: "started following", activity_target: index)
end

Activity.create( user_id: 1, activity_type: "update avatar" )
Activity.create( user_id: 1, activity_type: "update information" )

Activity.create( user_id: 2, activity_type: "update avatar" )
Activity.create( user_id: 2, activity_type: "update information" )
