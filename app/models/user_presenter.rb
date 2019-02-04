class UserPresenter
  attr_reader :repos, :followers, :followings, :user, :friends, :bookmarks

  def initialize(user)
    @user = user
    token = user.token
    @repos = user.repos(token)
    @followers = user.followers(token)
    @followings = user.following(token)
    @friends = user.friends
    @bookmarks = user.get_bookmarks
  end
end
