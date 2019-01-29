require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new("token")

    expect(service).to be_an_instance_of GithubService
  end
  it 'gets five repos for a user' do
    VCR.use_cassette("github_service") do
      repos = GithubService.find_repos("token")

      expect(repos.count).to eq(5)
      expect(repos[0][:name]).to eq("little-shop")
    end
  end
end
