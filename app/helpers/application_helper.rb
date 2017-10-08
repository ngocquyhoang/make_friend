module ApplicationHelper
  def avatar_for user
    if user.avatar?
      email_encode = Digest::MD5.new.update( user.email.to_s.strip.downcase ).hexdigest
      "<img src=\"http://www.gravatar.com/avatar/#{ email_encode }?s=350\" class=\"img-user-avatar\">".html_safe
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
