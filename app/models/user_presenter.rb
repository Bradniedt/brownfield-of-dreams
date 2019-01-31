class UserPresenter
  attr_reader :repos, :followers, :people_I_follow

  def initialize(user)
    @user = user
    token = user.token
    @repos = user.repos(token)
    @followers = user.followers(token)
    @people_I_follow = user.people_i_follow(token)
  end

end
