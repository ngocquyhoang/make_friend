class Admins::AccessController < ApplicationController
  before_action :authenticate_admin!
  
  layout :admin_layout

  protected
  def admin_layout
    "admins/layouts/application"
  end
end
