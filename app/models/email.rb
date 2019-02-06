class Email
  attr_reader :address
  def initialize(data = {})
    @address = set_address(data[:email])
    @message = ""
  end

  def self.find_address(token, name)
    result = GithubEmailService.find_email(token, name)[:email]
    binding.pry
    Email.new(result)
  end

  def set_address(result)
    if !result.include?("@")
      @message = "The Github user you selected doesn't have an email address associated with their account."
    else
      result
    end
  end
end
