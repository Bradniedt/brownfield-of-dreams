class FriendshipController < ApplicationController
  def create
    logged_in = User.find(params[:id])
    logged_in.add_friend(params[:name])
    redirect_to dashboard_path
  end
end
