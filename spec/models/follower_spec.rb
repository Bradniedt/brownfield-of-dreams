require 'rails_helper'

describe Follower do
  it 'exists' do
    data = {
      name: "Repo1",
      html_url: "www.hello.com"
    }
    follow = Follower.new(data)

    expect(follow).to be_an_instance_of Follower
  end
  it 'has attributes' do
    data = {
      name: "Repo1",
      url: "www.hello.com"
    }
    repo = Repo.new(data)

    expect(repo.name).to eq(data[:name])
    expect(repo.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      #VCR.use_cassette("github_follower_service") do
        token = "hello"
        followers = Follower.find_all(token)

        expect(followers.count).to eq(11)
        expect(followers[0]).to be_an_instance_of Follower
      #end
    end
  end
end
