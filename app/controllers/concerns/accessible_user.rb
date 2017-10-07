module AccessibleUser
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_user
      flash.clear
      redirect_to( users_dashboard_index_path ) && return
    end
  end
end
