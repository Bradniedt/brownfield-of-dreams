class Repo
  attr_reader :name, :url
  def initialize(data)
    @name = data[:name]
    @url = data[:html_url]
  end

  def self.find_all(token)
    filter = GithubService.find_repos(token).take(5)
    repos = filter.map { |data| Repo.new(data) }
    repos
  end
end
