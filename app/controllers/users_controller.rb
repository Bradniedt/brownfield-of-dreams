class UsersController < ApplicationController
  def show
    if current_user.token
      @repos = Repo.find_all(current_user.token)
      @followers = Follower.find_all(current_user.token)
      @people_I_follow = PersonIFollow.find_all(current_user.token)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
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
