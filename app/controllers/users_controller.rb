class UsersController < Users::AccessController
  before_action :set_user, only: :show

  def show
    redirect_to users_dashboard_index_path unless @user
  end

  def update
    
  end

  private

  def set_user
    @user = User.find_by_username( params[:username] )
    @user = User.find_by_id( params[:username] ) unless @user
  end
end
