class NotificationController < ApplicationController
  def create
    AccountNotifierMailer.inform(current_user).deliver_later
    redirect_to dashboard_path
  end
end
