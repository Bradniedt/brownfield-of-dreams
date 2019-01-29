require 'rails_helper'

describe Repo do
  it 'exists' do
    data = {
      name: "Repo1",
      html_url: "www.hello.com"
    }
    repo = Repo.new(data)

    expect(repo).to be_an_instance_of Repo
  end
  it 'has attributes' do
    data = {
      name: "Repo1",
      html_url: "www.hello.com"
    }
    repo = Repo.new(data)

    expect(repo.name).to eq(data[:name])
    expect(repo.url).to eq(data[:html_url])
  end
  describe 'class methods' do
    it '.find_all' do
      token = "8caaa533fb393a502d014a1df646d123588782ef"
      repos = Repo.find_all(token)

      expect(repos.count).to eq(5)
      expect(repos[0]).to be_an_instance_of Repo
    end
  end
end
