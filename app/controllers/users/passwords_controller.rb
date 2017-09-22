class Users::PasswordsController < Devise::PasswordsController
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
