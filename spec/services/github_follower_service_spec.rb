require 'rails_helper'

describe GithubFollowerService do
  it 'exists' do
    service = GithubFollowerService.new("token")

    expect(service).to be_an_instance_of GithubFollowerService
  end
  it 'gets followers for a user' do
    VCR.use_cassette("github_follower_service") do
      followers = GithubFollowerService.find_followers("token")

      expect(followers[0][:login]).to eq("abroberts5")
    end
  end
end
