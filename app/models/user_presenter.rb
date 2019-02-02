class UserPresenter
  attr_reader :repos, :followers, :people_i_follow

  def initialize(user)
    @user = user
    token = user.token
    @repos = user.repos(token)
    @followers = user.followers(token)
    @people_i_follow = user.people_i_follow(token)
  end

end
