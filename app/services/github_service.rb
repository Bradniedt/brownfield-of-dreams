class GithubService
  def initialize(token)
    @token = "token #{token}"
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

  def find_repos
    get_url("/user/repos")
  end

  def self.find_repos(token)
    new(token).find_repos
  end

  def find_friends
    get_url("/user/following")
  end

  def self.find_friends(token)
    new(token).find_friends
  end

  def find_followers
    get_url("/user/followers")
  end

  def self.find_followers(token)
    new(token).find_followers
  end

  def find_email(name)
    get_url("/users/#{name}")
  end

  def self.find_email(token, name)
    new(token).find_email(name)
  end
end
