class Users::SessionsController < Devise::SessionsController
  include AccessibleAdmin
  skip_before_action :check_admin, only: :destroy

  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
