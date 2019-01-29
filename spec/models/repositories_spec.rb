require 'rails_helper'

describe Repo do
  it 'exists' do
    data = {
      name: "Repo1",
      url: "www.hello.com"
    }
    repo = Repo.new(data)

    expect(repo).to be_an_instance_of Repo
  end
end
