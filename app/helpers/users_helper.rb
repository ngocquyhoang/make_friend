module UsersHelper
  def get_district_list province
    distric_list = ActiveSupport::JSON.decode(File.read('databases/address_district.json'))
    distric_list_of_province = []
    distric_list.each do |district|
      distric_list_of_province << district if district['Ten_Tinh_Thanh_Pho'] == province
    end

    return distric_list_of_province
  end

  def get_commune_list(province, district)
    commune_list = ActiveSupport::JSON.decode(File.read('databases/address_commune.json'))
    commune_list_of_province = []
    commune_list.each do |commune|
      if commune['Ten_Tinh_Thanh_Pho'] == province && commune['Ten_Quan_Huyen'] == district
        commune_list_of_province << commune 
      end
    end

    return commune_list_of_province
  end

  def get_school_list(province, district)
    school_list = ActiveSupport::JSON.decode(File.read('databases/highschool_list.json'))
    school_list_fil = []
    school_list.each do |school|
      unless province.nil? && district.nil?
        if ( (province.include? school['Ten_Tinh']) || (school['Ten_Tinh'].include? province) ) && ( (school['Ten_Quan_Huyen'].include? district) || (district.include? school['Ten_Quan_Huyen']) )
          school_list_fil << school 
        end
      end
    end

    return school_list_fil
  end

  def get_school_address user
    highschool_list = get_school_list(user.highschool_province, user.highschool_district)
    school_address = ""
    highschool_list.each do |highschool|
      school_address = "#{highschool['Dia_Chi']} - #{highschool['Ten_Tinh']}" if highschool['Ten_Truong'] == user.high_school
    end

    return school_address
  end

  def get_job_list
    jobs = []
    File.readlines('databases/job_list.txt').map do |line|
      jobs << line.split("\r\n")[0]
    end

    return jobs
  end

  def get_university_list
    university_list = []
    File.readlines('databases/univesity_list.txt').map do |line|
      university_list << line.split("\r\n")[0]
    end

    return university_list
  end

  def get_like_dislike_list
    like_dislike_list = []
    File.readlines('databases/like_disklike_list.txt').map do |line|
      like_dislike_list << line.split("\r\n")[0]
    end
    like_dislike_list = like_dislike_list.uniq

    return like_dislike_list
  end

  def set_activity(user, type, target )
    unless ( type.blank? && user.blank? )
      if target.blank?
        Activity.create(activity_type: type, user_id: user.id )
      else
        Activity.create(activity_type: type, user_id: user.id, activity_target: target.id )
      end
    end
  end
end
