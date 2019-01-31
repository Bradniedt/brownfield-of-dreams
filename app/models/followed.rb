class Followed
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:url]
  end

  def self.find_all(token)
    followed = GithubFollowedService.find_followed(token).map do |data|
      Followed.new(data)
    end
    followed
  end
end
