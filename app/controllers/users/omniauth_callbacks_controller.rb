class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
