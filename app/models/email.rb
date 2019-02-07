class Email
  attr_reader :address
  def initialize(data = {})
    @address = set_address(data)
  end

  def self.find_address(token, name)
    result = GithubService.find_email(token, name)[:email]
    Email.new(result)
  end

  def set_address(result)
    if result.nil?
      "The Github user you selected doesn't have an email address associated with their account."
    else
      result
    end
  end
end
