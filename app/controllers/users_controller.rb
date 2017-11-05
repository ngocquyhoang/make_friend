class UsersController < Users::AccessController
  include UsersHelper
  before_action :show_user, only: :show
  before_action :set_user, except: [
    :show, 
    :get_district_ajax, 
    :get_commune_ajax, 
    :get_highschool_district_ajax, 
    :get_highschool_list_ajax,
    :check_username_ajax,
    :delete_status_ajax,
    :update_status,
    :send_friend_request,
    :cancel_friend_request
  ]

  def show
    redirect_to users_dashboard_index_path unless @user
    @activities = @user.activities.limit(7).order('created_at DESC')
    @user_status = @user.statuses.limit(10).order('created_at DESC')

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
        unless params[:user].blank?
          @user.add_point( 20 ) if @user.avatar.blank?
          if @user.update(user_avatar_params)
            @user.reload
            set_activity(@user, "update avatar", nil)
          end
        end
        format.js {}
      end
    end
  end

  def update_information
    if @user == current_user
      infor_params = user_information_params.to_h
      infor_params[:job].shift
      if @user.job.blank?
        job_point = infor_params[:job].length
      else
        if infor_params[:job].length > @user.job.split("|").length
          job_point = infor_params[:job].length - @user.job.split("|").length
        else
          job_point = 0
        end
      end
      @user.add_point( job_point*5 )
      infor_params[:job] = infor_params[:job].join("|")
      infor_params[:hobby].shift
      if @user.hobby.blank?
        hobby_point = infor_params[:hobby].length
      else
        if infor_params[:hobby].length > @user.hobby.split("|").length
          hobby_point = infor_params[:hobby].length - @user.hobby.split("|").length
        else
          hobby_point = 0
        end
      end
      @user.add_point( hobby_point*5 )
      infor_params[:hobby] = infor_params[:hobby].join("|")
      infor_params[:dislike].shift
      if @user.dislike.blank?
        dislike_point = infor_params[:dislike].length
      else
        if infor_params[:dislike].length > @user.dislike.split("|").length
          dislike_point = infor_params[:dislike].length - @user.dislike.split("|").length
        else
          dislike_point = 0
        end
      end
      @user.add_point( dislike_point*5 )
      infor_params[:dislike] = infor_params[:dislike].join("|")

      @user.add_point( 10 ) if ( @user.username.blank? && !infor_params[:username].blank? )
      @user.add_point( 10 ) if ( @user.name.blank? && !infor_params[:name].blank? )
      @user.add_point( 10 ) if ( @user.gender.blank? && !infor_params[:gender].blank? )
      @user.add_point( 10 ) if ( @user.dob.blank? && !infor_params[:dob].blank? )
      @user.add_point( 10 ) if ( @user.address_commune.blank? && !infor_params[:address_commune].blank? )
      @user.add_point( 10 ) if ( @user.address_district.blank? && !infor_params[:address_district].blank? )
      @user.add_point( 10 ) if ( @user.address_province.blank? && !infor_params[:address_province].blank? )
      @user.add_point( 10 ) if ( @user.highschool_province.blank? && !infor_params[:highschool_province].blank? )
      @user.add_point( 10 ) if ( @user.highschool_district.blank? && !infor_params[:highschool_district].blank? )
      @user.add_point( 10 ) if ( @user.high_school.blank? && !infor_params[:high_school].blank? )
      @user.add_point( 10 ) if ( @user.univesity.blank? && !infor_params[:univesity].blank? )

      respond_to do |format|
        if @user.update(infor_params)
          @user.reload
          set_activity(@user, "update information", nil)
        end
        format.js {}
      end
    end
  end

  def update_status
    if current_user.id == user_update_status_params[:user_id].to_i && !user_update_status_params[:status].blank?
      respond_to do |format|
        @status = Status.new(user_update_status_params)
        if @status.save
          @status.reload
          set_activity(@status.user, "update status", nil)
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

  def delete_status_ajax
    status = Status.find_by_id( params[:status_id].to_i )
    if !status.nil? && status.user == current_user
      render json: { 'success': true, 'status_id': params[:status_id] } if status.destroy
    else
      render json: { 'success': false }
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

  def user_update_status_params
    params.require(:status).permit(:status, :user_id)
  end
end
