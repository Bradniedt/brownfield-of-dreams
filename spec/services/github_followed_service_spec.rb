require 'rails_helper'

describe GithubFollowedService do
  it 'exists' do
    service = GithubFollowedService.new("token")

    expect(service).to be_an_instance_of GithubFollowedService
  end
  it 'gets five repos for a user' do
    VCR.use_cassette("github_followed_service") do
      followers = GithubFollowedService.find_followed("token")

      expect(followers[0][:login]).to eq("iandouglas")
    end
  end
end
