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
  it 'my dashboard should have a github section with follower names as links' do
    VCR.use_cassette("repos_and_followers") do
      user = create(:user, token: "hello")
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".follower")

      within(".github") do
        expect(page).to have_link("abroberts5")
      end
    end
  end
  it 'my dashboard should have a github section with people I follow and their names as links' do
    VCR.use_cassette("friends") do
      user = create(:user, token: ENV['GITHUB_API_KEY'])
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".friend")

      within(".github") do
        expect(page).to have_link("iandouglas")
      end
    end
  end
end
