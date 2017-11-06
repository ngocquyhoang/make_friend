class Users::DashboardController < Users::AccessController
  def index
    @user = current_user

    suggestions_user = []
    User.all.each do |user|
      if ( @user != user ) && ( !@user.is_friend? user )
        user.trust_point += @user.match_point( user )
        suggestions_user << user
      end
    end
    @new_suggestions_point = suggestions_user.sort { |x,y| y[:trust_point] <=> x[:trust_point] }.take(5)

    wall_list = []
    User.all.each do |user|
      if ( @user == user ) || ( @user.is_friend? user )
        activities = user.activities.order('created_at DESC')
        activities.each do |activity|
          wall_list << { type: "activity", target: activity }
        end

        statuses = user.statuses.order('created_at DESC')
        statuses.each do |status|
          wall_list << { type: "statuses", target: status }
        end
      end
    end

    @new_wall_list = wall_list.sort { |x,y| y[:target].created_at <=> x[:target].created_at }.take(50)
  end
end
