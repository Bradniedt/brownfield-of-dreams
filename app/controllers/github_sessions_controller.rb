class GithubSessionsController < ApplicationController

  def create
    token = auth_hash["credentials"]["token"]
    user = User.find(current_user.id)
    user.update!(token: "token #{token}")
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
