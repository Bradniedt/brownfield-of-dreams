class InviteController < ApplicationController
  def show
  end

  def create
    #maybe sanitize the github name here
    result = Email.find_address(current_user.token, params[:github_handle])
    if result.address.chars.include?("@")
      AccountNotifierMailer.invite(result.address, current_user, params[:github_handle]).deliver_now
    else
      flash[:notice] = "#{result.address}"
    end
    redirect_to dashboard_path
  end
end
