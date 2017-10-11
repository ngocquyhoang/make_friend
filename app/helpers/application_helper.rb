module ApplicationHelper
  def avatar_for user
    if user.avatar?
      cl_image_tag(@user.avatar.full_public_id, :transformation=>[{:width=>400, :height=>400, :gravity=>"auto", :radius=>"max", :crop=>"crop"}, {:width=>200, :crop=>"scale"}])
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
end
