class UsersController < ApplicationController
  def show
    @user = UserPresenter.new(current_user) if current_user.token
    @bookmarks = current_user.get_bookmarks
    flash[:alert] = "This account has not yet been activated. Please check your email." if current_user.inactive?
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to notification_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
