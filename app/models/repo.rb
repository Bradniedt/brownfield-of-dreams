class Repo
  attr_reader :name, :url
  def initialize(data)
    @name = data[:name]
    @url = data[:html_url]
  end

  def self.find_all(token)
    repos = GithubService.find_repos(token).map do |data|
      Repo.new(data)
    end
    repos
  end
end
