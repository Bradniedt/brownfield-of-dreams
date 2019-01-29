require 'rails_helper'

describe Repo do

  it 'exists' do
    attributes = {}
    repo = Repo.new(attributes)
    expect(repo).to be_a(Repo)
  end

  it 'has attributes' do
    attributes = { name: "Repository 1",
                   html_url: "www.github.com/repository1"
    }
    repo = Repo.new(attributes)

    expect(repo.name).to eq(attributes[:name])
    expect(repo.url).to eq(attributes[:html_url])
  end
  describe 'Class Methods' do
    it '.find_all' do
      repos = Repo.find_all("whatever")

      expect(repos.count).to eq(5)
      expect(repos.first).to be_an_instance_of(Repo)
    end
  end
end
