class UserPresenter
  attr_reader :repos, :followers, :followings, :user

  def initialize(user)
    @user = user
    token = user.token
    @repos = user.repos(token)
    @followers = user.followers(token)
    @followings = user.following(token)
  end
end
