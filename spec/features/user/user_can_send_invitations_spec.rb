require 'rails_helper'

describe "As a user" do
  it 'I can send an invite to any github user' do
    VCR.use_cassette('github_followers_and_repos') do
      user = create(:user, token: "whatever")
      visit '/'
      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_link("Send an Invite")
      click_on("Send an Invite")
      expect(current_path).to eq(invite_path)

      fill_in 'github_handle', with: "Bradniedt"
      click_on("Send Invite")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end
  end
  it 'I cannot send an invite to a github user with no email' do
    VCR.use_cassette('github_followers_and_repos') do
      user = create(:user, token: "whatever")
      visit '/'
      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_link("Send an Invite")
      click_on("Send an Invite")
      expect(current_path).to eq(invite_path)

      fill_in 'github_handle', with: "SyntheticAutomation"
      click_on("Send Invite")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
