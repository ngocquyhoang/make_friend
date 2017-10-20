class UsersController < Users::AccessController
  before_action :show_user, only: :show
  before_action :set_user, except: :show

  def show
    redirect_to users_dashboard_index_path unless @user

    if @user == current_user
      @jobs = []
      File.readlines('databases/job_list.txt').map do |line|
        @jobs << line.split("\r\n")[0]
      end

      @like_dislike_list = []
      File.readlines('databases/like_disklike_list.txt').map do |line|
        @like_dislike_list << line.split("\r\n")[0]
      end
      @like_dislike_list = @like_dislike_list.uniq
    end
  end

  def upload_avatar
    if @user == current_user
      respond_to do |format|
        @user.reload if @user.update(user_avatar_params)
        format.js {}
      end
    end
  end

  def update_information
    if @user == current_user
      respond_to do |format|
        @user.reload if @user.update(user_information_params)
        format.js {}
      end
    end
  end

  private

  def show_user
    @user = User.find_by_username( params[:username] )
    @user = User.find_by_id( params[:username] ) unless @user
  end

  def set_user
    @user = User.find params[:id]
  end

  def user_information_params
    params.require(:user).permit(:username, :name)
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
end
