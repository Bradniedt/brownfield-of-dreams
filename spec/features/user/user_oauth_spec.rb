require 'rails_helper'

describe 'User Oauth' do
  it 'can see the link to connect to github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_button('Connect to Github')
  end
  it 'omniauth provides token' do
    VCR.use_cassette("oauth") do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        "credentials" => {"token" => ENV['GITHUB_API_KEY']}
        })
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_button('Connect to Github')
    end
  end
end
