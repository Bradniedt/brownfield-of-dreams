class Friend
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:url]
  end

  def self.find_all(token)
    friends = GithubFriendsService.find_friends(token).map do |data|
      Friend.new(data)
    end
    friends
  end
end
