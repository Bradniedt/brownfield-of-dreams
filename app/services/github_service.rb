class GithubService
  def initialize(token)
    @token = ENV['GITHUB_API_KEY']
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def find_repos
    get_url("/user/repos")
  end

  def self.find_repos(token)
    new(token).find_repos
  end
end
