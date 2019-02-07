class GithubEmailService
  def initialize(token, githubname)
    @token = "token #{token}"
    @name = githubname
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def find_email
    get_url("/users/#{@name}")
  end

  def self.find_email(token, name)
    new(token, name).find_email
  end
end
