class Users::RegistrationsController < Devise::RegistrationsController
  include Accessible
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
