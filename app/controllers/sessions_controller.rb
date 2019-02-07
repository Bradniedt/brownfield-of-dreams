class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    valid(user) ? generate_session(user) : display_error
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def valid(user)
    user && user.authenticate(params[:session][:password])
  end

  def generate_session(user)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def display_error
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end

end
