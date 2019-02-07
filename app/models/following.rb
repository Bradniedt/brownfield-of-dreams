class Following
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:url]
  end

  def self.find_all(token)
    friends = GithubService.find_friends(token).map do |data|
      Following.new(data)
    end
    friends
  end
end
