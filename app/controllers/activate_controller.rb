class ActivateController < ApplicationController
  def create
    User.find(current_user.id).update(status: 1)
    flash[:notice] = "Thanks! Your account has been activated!"
    redirect_to dashboard_path
  end
end
