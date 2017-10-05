module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_admin
      redirect_to( admins_dashboard_index_path ) && return
    elsif current_user
      redirect_to( users_dashboard_index_path ) && return
    end
  end
end
