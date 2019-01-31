require 'rails_helper'

describe Followed do
  it 'exists' do
    data = {
      login: "Name1",
      url: "www.hello.com"
    }
    follow = Followed.new(data)

    expect(follow).to be_an_instance_of Followed
  end
  it 'has attributes' do
    data = {
      login: "Repo1",
      url: "www.hello.com"
    }
    follow = Followed.new(data)

    expect(follow.name).to eq(data[:login])
    expect(follow.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      VCR.use_cassette("github_followed_service") do
        token = "hello"
        followers = Followed.find_all(token)

        expect(followers.count).to eq(12)
        expect(followers[0]).to be_an_instance_of Followed
      end
    end
  end
end
