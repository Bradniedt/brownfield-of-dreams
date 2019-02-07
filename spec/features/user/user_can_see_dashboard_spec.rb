require 'rails_helper'

describe "A default visitor to our app" do
  it 'can see github repos when logged in' do
    VCR.use_cassette('repos_and_followers') do
      user = create(:user, token: ENV['GITHUB_API_KEY'])
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
      user = create(:user, token: ENV['GITHUB_API_KEY'])
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".follower")

      within(".github") do
        expect(page).to have_link("cebarks")
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
      expect(page).to have_css(".following")

      within(".github") do
        expect(page).to have_link("mgoodhart5")
      end
    end
  end
  it 'shows me my bookmarks' do
    VCR.use_cassette("friends") do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      tutorial_3 = create(:tutorial)
      video_1 = create(:video, position: 1, tutorial: tutorial_1)
      video_2 = create(:video, position: 3, tutorial: tutorial_3)
      video_3 = create(:video, position: 2, tutorial: tutorial_2)
      video_4 = create(:video)
      user_1 = create(:user)
      user_video_1 = UserVideo.create(user: user_1, video: video_1)
      user_video_2 = UserVideo.create(user: user_1, video: video_2)
      user_video_3 = UserVideo.create(user: user_1, video: video_3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path
      expect(page).to have_content("My Bookmarks")
      expect(page).to have_css(".bookmarks")
      within(first(".bookmarks")) do
        expect(page).to have_css(".bookmark-link")
        expect(page).to have_link("#{video_1.title}")
      end
    end
  end
end
