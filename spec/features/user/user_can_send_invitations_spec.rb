require 'rails_helper'

describe "As a user" do
  it 'I can send an invite to any github user' do
    VCR.use_cassette('github_emails') do
      clear_emails
      user = create(:user, token: "#{ENV['GITHUB_API_KEY']}")
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

      fill_in 'github_handle', with: "Jcasimir"
      click_on("Send Invite")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")

      open_email('jeff@turing.io')
      expect(current_email).to have_content('has invited you to join Brownfield Tutorials. You can create an account here')

      current_email.click_link 'Signup'
      expect(current_path).to eq(register_path)
    end
  end
  it 'I cannot send an invite to a github user with no email' do
    VCR.use_cassette('invitation') do
      user = create(:user, token: "#{ENV['GITHUB_API_KEY']}")
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
