class ActivateController < ApplicationController
  def create
    User.find(current_user.id).update!(status: 1)
    flash[:notice] = "Thank you! Your account is now activated!"
    redirect_to dashboard_path
  end
end
