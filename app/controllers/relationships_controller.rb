class RelationshipsController < ApplicationController
  include UsersHelper
  def create
    @user = User.find(params[:receive_user_id])
    current_user.send_request( @user )
    set_activity(current_user, "send friend request", @user)
    
    respond_to do |format|
      format.js
    end
  end

  def accept_friend
    @user = User.find params[:user_id]
    @user_status = @user.statuses.limit(10).order('created_at DESC')
    current_user.accept_request( @user )
    current_user.add_point( 10 )
    @user.add_point( 10 )
    set_activity( current_user, "accept friend request", @user)
    set_activity( current_user, "being friend", @user)
    set_activity( @user, "being friend", current_user)

    respond_to do |format|
      format.js
    end
  end

  def refused_friend
    @user = User.find params[:user_id]
    current_user.refused_request( @user )
    @user.add_point( -10 )
    set_activity(current_user, "decline friend request", @user)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).receive_user
    current_user.cancel_request( @user )
    set_activity(current_user, "cancel friend request", @user)

    respond_to do |format|
      format.js
    end
  end
end
