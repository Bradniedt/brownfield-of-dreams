require 'rails_helper'

describe Follower do
  it 'exists' do
    data = {
      login: "Follower1",
      url: "www.hello.com"
    }
    follower = Follower.new(data)

    expect(follower).to be_an_instance_of Follower
  end
  it 'has attributes' do
    data = {
      login: "Follower1",
      url: "www.hello.com"
    }
    follower = Follower.new(data)

    expect(follower.login).to eq(data[:login])
    expect(follower.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      VCR.use_cassette("github_follower_service") do
        token = "hello"
        followers = Follower.find_all(token)

        expect(followers.count).to eq(11)
        expect(followers[0]).to be_an_instance_of Follower
      end
    end
  end
end
