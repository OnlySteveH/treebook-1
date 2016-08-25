class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]


  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] ="Friend requiered"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

 def create
   if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
     @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
     @user_friendship = current_user.user_friendships.new(friend: @friend)
     @user_friendship.save
     flash[:success] = "You are now friend with #{@friend.full_name}"
     redirect_to profile_path(@friend)
   else
     flash[:error] = "Friend requiered"
     redirect_to root_path
   end
 end


  private
  def user_friendship_params
    params.require(:friendship).permit(:user, :friend, :user_id, :friend_id, :state)
  end
end
