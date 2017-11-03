class Users::ConfirmationsController < Devise::ConfirmationsController
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
