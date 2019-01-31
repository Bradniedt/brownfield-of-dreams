class Follower
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:url]
  end

  def self.find_all(token)
    followers = GithubFollowerService.find_followers(token).map do |data|
      Follower.new(data)
    end
    followers
  end
end
