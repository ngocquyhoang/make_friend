class UsersController < Users::AccessController
  before_action :set_user, only: :show

  def show
    redirect_to users_dashboard_index_path unless @user
  end

  private

  def set_user
    @user = User.find_by_username(params[:username])
  end
end
