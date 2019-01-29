class Repo
  attr_reader :name, :url
  def initialize(data)
    @name = data[:name]
    @url = data[:html_url]
  end

  def self.find_all(token)
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{token}"
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
    response = @conn.get("/user/repos")
    raw_repos = JSON.parse(response.body, symbolize_names: true).take(5)
    raw_repos.map do |data|
      Repo.new(data)
    end
  end
end
