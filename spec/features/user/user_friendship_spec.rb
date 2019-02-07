require 'rails_helper'

describe 'User Friendship Functionality' do
  it 'A user can add a friend.' do
    VCR.use_cassette("friend") do
      user1 = create(:user, token: ENV['GITHUB_API_KEY'])
      user2 = create(:user, githubname: "mgoodhart5")
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user1.email
      fill_in 'session[password]', with: user1.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".following")

      within("#mgoodhart5") do
        expect(page).to have_link("mgoodhart5")
        expect(page).to have_link("Add as Friend")
        click_on("Add as Friend")
      end
      within("#mgoodhart5") do
        expect(page).to_not have_link("Add as Friend")
      end
    end
  end
  it 'A user can add a friend and see them in their friends list.' do
    VCR.use_cassette("friendship") do
      user1 = create(:user, token: ENV['GITHUB_API_KEY'])
      user2 = create(:user, githubname: "mgoodhart5")
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user1.email
      fill_in 'session[password]', with: user1.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".following")

      within("#mgoodhart5") do
        expect(page).to have_link("mgoodhart5")
        expect(page).to have_link("Add as Friend")
        click_on("Add as Friend")
      end
      within(".myfriends") do
        expect(page).to have_content(user2.first_name)
        expect(page).to have_content(user2.last_name)
      end
    end
  end
end
