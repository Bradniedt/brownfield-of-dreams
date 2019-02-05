require 'rails_helper'

describe 'A visitor to our app' do
  it 'registration' do
    email = "fresh_baked_honeybun@healthyicing.gov"
    first_name = "Davoin"
    last_name = "Shower Handle"
    password_confirmation = "password"

    visit "/"

    click_link "Register"

    expect(current_path).to eq(register_path)

    fill_in :user_email, with: email
    fill_in :user_first_name, with: first_name
    fill_in :user_last_name, with: last_name
    fill_in :user_password, with: password_confirmation
    fill_in :user_password_confirmation, with: password_confirmation

    click_button "Create Account"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content "Logged in as #{first_name}"
    expect(page).to have_content "This account has not yet been activated. Please check your email."

    # When I check my email for the registration email
    background do
      clear_emails
      visit email_trigger_path
      open_email('fresh_baked_honeybun@healthyicing.gov')
    end
    
    # I should see a message that says "Visit here to activate your account."
    expect(current_email).to have_content "Visit here to activate your account."

    # And when I click on that link
    current_email.click_link 'Activate'

    # Then I should be taken to a page that says "Thank you! Your account is now activated."
    expect(page).to have_content "Thank you! Your account is now activated."

    # And when I visit "/dashboard"
    visit dashboard_path

    # Then I should see "Status: Active"
    expect(page).to have_content "Status: Active" #titlecase in the view or in controller.

  end
end
