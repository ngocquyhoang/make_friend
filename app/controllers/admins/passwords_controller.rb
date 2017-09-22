class Admins::PasswordsController < Devise::PasswordsController
  layout :admin_layout

  protected
  def admin_layout
    "admins/layouts/application"
  end
end
