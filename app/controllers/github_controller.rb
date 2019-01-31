class GithubController < ApplicationController

  def create
    current_user.add_github(auth_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
