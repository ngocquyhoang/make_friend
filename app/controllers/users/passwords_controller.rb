class Users::PasswordsController < Devise::PasswordsController
  include AccessibleAdmin
  
  layout :user_layout

  def send_instructions_successfull
  end

  protected
  def user_layout
    "users/layouts/application"
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    users_send_instructions_successfull_path
  end
end
