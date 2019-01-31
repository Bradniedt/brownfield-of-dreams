require 'rails_helper'

describe GithubPeopleIFollowService do
  it 'exists' do
    service = GithubPeopleIFollowService.new("token")

    expect(service).to be_an_instance_of GithubPeopleIFollowService
  end
  it 'gets people a user follows for' do
    VCR.use_cassette("people_i_follow") do
      people = GithubPeopleIFollowService.find_people_i_follow("token")

      expect(people[0][:login]).to eq("iandouglas")
    end
  end
end
