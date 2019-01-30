require 'rails_helper'

describe "A default visitor to our app" do
  it 'can see github repos when logged in' do
    VCR.use_cassette('github_followers_and_repos') do
      user = create(:user, token: "whatever")
      visit '/'
      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".repo", count: 5)
      within(".github") do
        expect(page).to have_content("Repositories")
        expect(page).to have_link("activerecord-obstacle-course")
      end
    end
  end
  it 'cannot see github repos if current user does not have a token' do
      user = create(:user)
      visit '/'
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_css(".repo")
      expect(page).to_not have_css(".github")
  end
  it 'can see followers when logged in' do
    VCR.use_cassette('github_followers_and_repos') do
      user = create(:user, token: "whatever")
      visit '/'
      click_on "Sign In"

      expect(current_path).to eq(login_path)
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
      save_and_open_page
      expect(page).to have_css(".follower")
    end
  end
end
