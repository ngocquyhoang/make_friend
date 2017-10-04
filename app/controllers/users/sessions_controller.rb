class Users::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: [:destroy, :create, :new]
  before_action :check_user_has_flash, only: [:new, :create]

  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
