require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new("token")

    expect(service).to be_an_instance_of GithubService
  end
  it 'gets five repos for a user' do
    VCR.use_cassette("github_service") do
      repos = Repo.find_all(ENV['GITHUB_API_KEY'])

      expect(repos.count).to eq(5)
      expect(repos[0]).to be_an_instance_of Repo
    end
  end
  it 'gets five repos for a user' do
    VCR.use_cassette("github_follower_service") do
      followers = Follower.find_all(ENV['GITHUB_API_KEY'])

      expect(followers[0]).to be_an_instance_of Follower
    end
  end
  it 'gets people a user follows for' do
    VCR.use_cassette("friends") do
      people = Following.find_all(ENV['GITHUB_API_KEY'])
      expect(people[0]).to be_an_instance_of Following
    end
  end
  it 'gets email of a user' do
    VCR.use_cassette("email_response") do
      name = "Jcasimir"
      email = GithubService.find_email(ENV['GITHUB_API_KEY'], name)

      expect(email[:email]).to eq("jeff@turing.io")
    end
  end
end
