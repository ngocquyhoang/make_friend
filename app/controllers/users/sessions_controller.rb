class Users::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
