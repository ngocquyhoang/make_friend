class Users::AccessController < ApplicationController
  before_action :authenticate_user!
  
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end
end
