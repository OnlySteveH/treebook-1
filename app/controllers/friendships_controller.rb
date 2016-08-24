class FriendshipsController < ApplicationController


  private
  def params_friendship
    params.require(:friendship).permit(:user, :friend, :user_id, :friend_id)
  end
end
