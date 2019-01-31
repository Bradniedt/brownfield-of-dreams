require 'rails_helper'

describe GithubFriendsService do
  it 'exists' do
    service = GithubFriendsService.new("token")

    expect(service).to be_an_instance_of GithubFriendsService
  end
  it 'gets people a user follows for' do
    VCR.use_cassette("friends") do
      people = GithubFriendsService.find_friends("token")

      expect(people[0][:login]).to eq("iandouglas")
    end
  end
end
