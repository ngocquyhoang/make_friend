class Admins::PasswordsController < Devise::PasswordsController
  include AccessibleUser
  
  layout :admin_layout

  protected
  def admin_layout
    "admins/layouts/application"
  end
end
