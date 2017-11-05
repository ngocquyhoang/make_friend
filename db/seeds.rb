require 'faker'
require 'unicode_utils'

User.create( email: 'ngocquyhoang.93@gmail.com', username: 'ngocquyhoang', name: 'Hoang Ngoc Quy', trust_point: 230, gender: 'male', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )

Activity.create( user_id: 1, activity_type: "update avatar" )
Activity.create( user_id: 1, activity_type: "update information" )

Status.create( user_id: 1, status: Faker::Lorem.paragraph )
Status.create( user_id: 1, status: Faker::Lorem.paragraph(2) )

(2..20).each do |index|
  case index%3
  when 2
    userofname = Faker::Name.unique.name
    User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{userofname}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{userofname}", trust_point: 230, gender: 'female', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
    user = User.find index
    puts "Created #{user.name}"
  when 1
    userofname = Faker::Name.unique.name
    user = User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{userofname}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{userofname}", trust_point: 230, gender: 'male', password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
    user = User.find index
    puts "Created #{user.name}"
  else
    userofname = Faker::Name.unique.name
    user = User.create( email: "#{Faker::Internet.unique.email}", username: UnicodeUtils.downcase("#{userofname}", :tr).gsub(/[()-,. @*&$#^!']/, ''), name: "#{userofname}", trust_point: 220, password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
    user = User.find index
    puts "Created #{user.name}"
  end

  Activity.create( user_id: index, activity_type: "update avatar" )
  Activity.create( user_id: index, activity_type: "update information" )

  Status.create( user_id: index, status: Faker::Lorem.paragraph )
  Status.create( user_id: index, status: Faker::Lorem.paragraph(2) )
end
