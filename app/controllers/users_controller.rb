class UsersController < Users::AccessController
  include UsersHelper
  before_action :show_user, only: :show
  before_action :set_user, except: [
    :show, 
    :get_district_ajax, 
    :get_commune_ajax, 
    :get_highschool_district_ajax, 
    :get_highschool_list_ajax,
    :check_username_ajax
  ]

  def show
    redirect_to users_dashboard_index_path unless @user
    @activities = @user.activities.limit(7).order('created_at DESC')

    if @user == current_user
      @jobs = get_job_list
      @like_dislike_list = get_like_dislike_list
      @university_list = get_university_list
      
      @address_province_list = ActiveSupport::JSON.decode(File.read('databases/address_province.json'))
      @distric_list_of_province = get_district_list(@user.address_province)
      @commune_list_of_province = get_commune_list(@user.address_province, @user.address_district)

      @address_highschool_province_list = ActiveSupport::JSON.decode(File.read('databases/address_province.json'))
      @address_highschool_district_list = get_district_list(@user.highschool_province)
      @highschool_list = get_school_list(@user.highschool_province, @user.highschool_district)
    end
  end

  def upload_avatar
    if @user == current_user
      respond_to do |format|
        if @user.update(user_avatar_params)
          @user.reload
          set_activity(@user, "update avatar", nil)
        end
        format.js {}
      end
    end
  end

  def update_information
    infor_params = user_information_params.to_h
    infor_params[:job].shift
    infor_params[:job] = infor_params[:job].join("|")
    infor_params[:hobby].shift
    infor_params[:hobby] = infor_params[:hobby].join("|")
    infor_params[:dislike].shift
    infor_params[:dislike] = infor_params[:dislike].join("|")

    if @user == current_user
      respond_to do |format|
        if @user.update(infor_params)
          @user.reload
          set_activity(@user, "update information", nil)
        end
        format.js {}
      end
    end
  end

  def get_district_ajax
    render json: { 'distric_list': get_district_list(params['province']) }
  end

  def get_commune_ajax
    render json: { 'commune_list': get_commune_list(params['province'], params['district']) }
  end

  def get_highschool_district_ajax
    render json: { 'distric_list': get_district_list(params['province']) }
  end

  def get_highschool_list_ajax
    render json: { 'school_list': get_school_list(params['province'], params['district']) }
  end

  def check_username_ajax
    if params['username'] != current_user.username
      is_valid = User.new(email: 'user@example.com', password: '123456789', password_confirmation: '123456789', username: params['username']).valid?
      render json: { 'is_valid': is_valid }
    else
      render json: { 'is_valid': true }
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
    params.require(:user).permit(:username, :name, :gender, :dob, { :job => [] }, { :hobby => [] }, { :dislike => [] }, :address_commune, :address_district, :address_province, :highschool_province, :highschool_district, :high_school, :univesity)
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
end
