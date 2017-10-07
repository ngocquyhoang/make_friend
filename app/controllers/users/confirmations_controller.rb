class Users::ConfirmationsController < Devise::ConfirmationsController
  include AccessibleAdmin

  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
