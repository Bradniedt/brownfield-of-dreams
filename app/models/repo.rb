class Repo
  attr_reader :name, :url

  def initialize(attributes = {})
    @name = attributes[:name]
    @url = attributes[:html_url]
  end

  def self.find_all(token)
    token = ENV['GITHUB_API_KEY']
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{token}"
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
    response = @conn.get("/user/repos")
    results = JSON.parse(response.body, symbolize_names: true).take(5)
    @repos = results.map do |result|
      Repo.new(result)
    end
  end
end
