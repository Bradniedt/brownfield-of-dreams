class NotificationController < ApplicationController
  def create
    AccountNotifierMailer.inform(current_user).deliver_now
    flash[:notice] = "This account has not yet been activated. Please check your email."
    redirect_to dashboard_path
  end
end
