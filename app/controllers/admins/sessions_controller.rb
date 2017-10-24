class Admins::SessionsController < Devise::SessionsController
  include AccessibleUser
  skip_before_action :check_user, only: :destroy
  
  layout :admin_layout

  protected
  def admin_layout
    "admins/layouts/application"
  end
end
