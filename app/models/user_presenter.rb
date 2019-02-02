class UserPresenter
  attr_reader :repos, :followers, :friends

  def initialize(user)
    @user = user
    token = user.token
    @repos = user.repos(token)
    @followers = user.followers(token)
    @friends = user.friends(token)
  end

end
