class GithubController < ApplicationController
  def create
    User.from_omniauth(request.env["omniauth.auth"], current_user.id)
    redirect_to dashboard_path
  end
end
