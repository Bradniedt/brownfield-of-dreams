require 'rails_helper'

describe Follower do
  it 'exists' do
    data = {
      login: "Name1",
      url: "www.hello.com"
    }
    follow = Follower.new(data)

    expect(follow).to be_an_instance_of Follower
  end
  it 'has attributes' do
    data = {
      login: "Repo1",
      url: "www.hello.com"
    }
    follow = Follower.new(data)

    expect(follow.name).to eq(data[:login])
    expect(follow.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      VCR.use_cassette("github_follower_service") do
        token = "hello"
        followers = Follower.find_all(token)

<<<<<<< HEAD
=======
      
>>>>>>> 9c18dd6f1a6e84147a31a7c4e039ea5595273449
        expect(followers[0]).to be_an_instance_of Follower
      end
    end
  end
end
