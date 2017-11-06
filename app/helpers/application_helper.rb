module ApplicationHelper
  def avatar_for user
    if user.avatar?
      cl_image_tag(user.avatar.full_public_id, :transformation=>[{:width=>400, :height=>400, :gravity=>"auto", :radius=>"max", :crop=>"crop"}, {:width=>200, :crop=>"scale"}])
    else
      if user.gender == "male"
        image_tag "user-avatar-male.png", class: "img-user-avatar"
      elsif user.gender == "female"
        image_tag "user-avatar-female.png", class: "img-user-avatar"
      else
        image_tag "user-avatar-default.png", class: "img-user-avatar"
      end
    end
  end

  def stick_avatar_for user
    if user.avatar?
      avatar = cl_image_tag(user.avatar.full_public_id, :transformation=>[{:width=>400, :height=>400, :gravity=>"auto", :radius=>"max", :crop=>"crop"}, {:width=>200, :crop=>"scale"}], class: "ui avatar image")
    else
      if user.gender == "male"
        avatar = image_tag "user-avatar-male.png", class: "ui avatar image"
      elsif user.gender == "female"
        avatar = image_tag "user-avatar-female.png", class: "ui avatar image"
      else
        avatar = image_tag "user-avatar-default.png", class: "ui avatar image"
      end
    end

    user_link_path = user.username? ? user_path(user.username) : user_path(user.id)
    if user.name?
      name = user.name
    else
      if user.username?
        name = "@#{user.username}"
      else 
        name = user.email
      end
    end
    return "<a href='#{user_link_path}' class='stick-avatar no-outline'>#{avatar} #{name}</a>".html_safe
  end

  def activity_label activity
    case activity.activity_type
    when "update avatar"
      return "#{stick_avatar_for activity.user} was update his avatar".html_safe
    when "update status"
      return "#{stick_avatar_for activity.user} was update his status".html_safe
    when "being friend"
      return "#{stick_avatar_for activity.user} and #{stick_avatar_for( User.find activity.activity_target )} now is friend".html_safe
    when "send friend request"
      return "#{stick_avatar_for activity.user} send friend request to #{stick_avatar_for( User.find activity.activity_target )}".html_safe
    when "accept friend request"
      return "#{stick_avatar_for activity.user} accept friend request from #{stick_avatar_for( User.find activity.activity_target )}".html_safe
    when "cancel friend request"
      return "#{stick_avatar_for activity.user} cancel friend request to #{stick_avatar_for( User.find activity.activity_target )}".html_safe
    when "decline friend request"
      return "#{stick_avatar_for activity.user} decline friend request from #{stick_avatar_for( User.find activity.activity_target )}".html_safe
    else
      return "#{stick_avatar_for activity.user} was update information".html_safe
    end
  end

  def address_for user
    address = []
    address << user.address_commune if user.address_commune?
    address << user.address_district if user.address_district?
    address << user.address_province if user.address_province?
    return address.join(' - ')
  end
end
