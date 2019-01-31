class GithubFriendsService
  def initialize(token)
    @token = token
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

  def find_friends
    get_url("/user/following")
  end

  def self.find_friends(token)
    new(token).find_friends
  end
end