class GithubController < ApplicationController
  def create
    current_user.add_github(request.env["omniauth.auth"])
    redirect_to dashboard_path
  end
end
