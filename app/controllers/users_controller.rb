class UsersController < ApplicationController
  def show
    @user = UserPresenter.new(current_user) if current_user.token
    @bookmarks = current_user.get_bookmarks
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    user.save ? generate_session(user) : display_error
  end

  private

  def display_error
    flash[:error] = 'Username already exists'
    render :new
  end

  def generate_session(user)
    session[:user_id] = user.id
    flash[:notice] = "Logged in as #{user.first_name}"
    display_alert(user)
    redirect_to notification_path
  end

  def display_alert(user)
    flash[:alert] = "This account has not yet been activated. Please check your email." unless user.active?
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
