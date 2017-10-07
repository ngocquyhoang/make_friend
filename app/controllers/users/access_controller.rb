class Users::AccessController < ApplicationController
  before_action :authenticate_user!
  before_action :set_global_layout
  
  layout :user_layout

  protected
  def user_layout
    "users/layouts/application"
  end

  def set_global_layout
    @is_global_layout = true
  end
end
