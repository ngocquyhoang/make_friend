class Users::SessionsController < Devise::SessionsController
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
