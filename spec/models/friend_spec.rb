require 'rails_helper'

describe Friend do
  it 'exists' do
    data = {
      login: "Friend1",
      url: "www.hello.com"
    }
    people = Friend.new(data)

    expect(people).to be_an_instance_of Friend
  end
  it 'has attributes' do
    data = {
      login: "Friend1",
      html_url: "www.hello.com"
    }
    person = Friend.new(data)

    expect(person.name).to eq(data[:login])
    expect(person.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      VCR.use_cassette("friends") do
        token = "hello"
        people = Friend.find_all(token)

        expect(people[0]).to be_an_instance_of Friend
      end
    end
  end
end
