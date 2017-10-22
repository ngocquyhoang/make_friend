class UsersController < Users::AccessController
  include UsersHelper
  before_action :show_user, only: :show
  before_action :set_user, except: [:show, :get_district_ajax, :get_commune_ajax]

  def show
    redirect_to users_dashboard_index_path unless @user

    if @user == current_user
      @jobs = get_job_list
      @like_dislike_list = get_like_dislike_list
      
      @address_province_list = ActiveSupport::JSON.decode(File.read('databases/address_province.json'))
      @distric_list_of_province = get_district_list(@user.address_province)
      @commune_list_of_province = get_commune_list(@user.address_province, @user.address_district)

      @address_highschool_province_list = []
      @address_highschool_district_list = []
      @highschool_list = []
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
    infor_params = user_information_params.to_h
    infor_params[:job].shift
    infor_params[:job] = infor_params[:job].join("|")
    infor_params[:hobby].shift
    infor_params[:hobby] = infor_params[:hobby].join("|")
    infor_params[:dislike].shift
    infor_params[:dislike] = infor_params[:dislike].join("|")

    if @user == current_user
      respond_to do |format|
        @user.reload if @user.update(infor_params)
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

  private

  def show_user
    @user = User.find_by_username( params[:username] )
    @user = User.find_by_id( params[:username] ) unless @user
  end

  def set_user
    @user = User.find params[:id]
  end

  def user_information_params
    params.require(:user).permit(:username, :name, :gender, :dob, { :job => [] }, { :hobby => [] }, { :dislike => [] }, :address_commune, :address_district, :address_province)
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
end
