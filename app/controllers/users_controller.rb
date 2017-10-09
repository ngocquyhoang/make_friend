class UsersController < Users::AccessController
  before_action :show_user, only: :show
  before_action :set_user, except: :show

  def show
    redirect_to users_dashboard_index_path unless @user
  end

  def update
    
  end

  def upload_avatar
    if @user == current_user
      # byebug
      # respond_to do |format|
        if @user.update(user_avatar_params)
          respond_to :js
          # format.html { render(:text => "not implemented") }
        else
          # format.js
          # format.html { render(:text => "not implemented") }
        end
        # format.js
      # end
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

  def user_params
    params.require(:user).permit(:username, :name)
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
end
