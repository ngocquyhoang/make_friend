require 'faker'
require 'unicode_utils'

User.create( email: 'ngocquyhoang.93@gmail.com', username: 'ngocquyhoang', name: 'Hoang Ngoc Quy', gender: 'male', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
User.create( email: 'ngocquyhoang2911@gmail.com', username: 'ngocquyhoang2911', name: 'Hoang Ngoc Quy', gender: 'male', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )

Activity.create( user_id: 1, activity_type: "update avatar" )
Activity.create( user_id: 1, activity_type: "update information" )

Activity.create( user_id: 2, activity_type: "update avatar" )
Activity.create( user_id: 2, activity_type: "update information" )

(3..99).each do |index|
  case index%3
  when 2
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", gender: 'female', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  when 1
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", gender: 'male', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  when 0
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{Faker::Name.unique.name}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{Faker::Name.unique.name}", password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
  end
  Activity.create( user_id: index, activity_type: "update avatar" )
  Activity.create( user_id: index, activity_type: "update information" )
end
