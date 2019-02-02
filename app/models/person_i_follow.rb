class PersonIFollow
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:url]
  end

  def self.find_all(token)
    people_i_follow = GithubPeopleIFollowService.find_people_i_follow(token).map do |data|
      PersonIFollow.new(data)
    end
    people_i_follow
  end
end
