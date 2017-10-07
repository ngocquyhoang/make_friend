module AccessibleAdmin
  extend ActiveSupport::Concern
  included do
    before_action :check_admin
  end

  protected
  def check_admin
    if current_admin
      flash.clear
      redirect_to( admins_dashboard_index_path ) && return
    end
  end
end
