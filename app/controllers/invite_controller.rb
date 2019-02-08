class InviteController < ApplicationController
  def show
  end

  def create
    result = Email.find_address(current_user.token, params[:github_handle])
    email(result) ? send_invite(result) : send_notice(result)
    redirect_to dashboard_path
  end

  private

  def email(result)
    result.address.chars.include?("@")
  end

  def send_invite(result)
    AccountNotifierMailer.invite(result.address, current_user, params[:github_handle]).deliver_later
    flash[:notice] = "Successfully sent invite!"
  end

  def send_notice(result)
    flash[:notice] = "#{result.address}"
  end

end
