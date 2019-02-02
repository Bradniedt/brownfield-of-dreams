require 'rails_helper'

describe 'User Friendship Functionality' do
  it 'A user can add a friend.' do

    VCR.use_cassette("friends") do
      user1 = create(:user, token: ENV['GITHUB_API_KEY'])
      user2 = create(:user, githubname: "iandouglas")
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user1.email
      fill_in 'session[password]', with: user1.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".following")

      within("#iandouglas") do
        expect(page).to have_link("iandouglas")
        expect(page).to have_link("Add as Friend")
        click_on("Add as Friend")
      end
      within("#iandouglas") do
        expect(page).to have_link("iandouglas")
        expect(page).to_not have_link("Add as Friend")
      end
    end
  end
end
