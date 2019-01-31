require 'rails_helper'

describe PersonIFollow do
  it 'exists' do
    data = {
      login: "PersonIFollow1",
      url: "www.hello.com"
    }
    people = PersonIFollow.new(data)

    expect(people).to be_an_instance_of PersonIFollow
  end
  it 'has attributes' do
    data = {
      login: "PersonIFollow1",
      html_url: "www.hello.com"
    }
    person = PersonIFollow.new(data)

    expect(person.name).to eq(data[:login])
    expect(person.url).to eq(data[:url])
  end
  describe 'class methods' do
    it '.find_all' do
      VCR.use_cassette("people_i_follow") do
        token = "hello"
        people = PersonIFollow.find_all(token)

        expect(people[0]).to be_an_instance_of PersonIFollow
      end
    end
  end
end
