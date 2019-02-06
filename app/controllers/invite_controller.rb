class InviteController < ApplicationController
  def show
  end

  def create
    #maybe sanitize the github name here
    result = Email.find_address(current_user.token, params[:github_handle])
    binding.pry
    if result.address.include?("@")
      #send email
    else
      flash[:alert] = "#{result.message}"
    end
  end
end
