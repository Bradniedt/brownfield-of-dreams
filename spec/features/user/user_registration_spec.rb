require 'rails_helper'

# As a guest user
describe 'A visitor to our app' do
  it 'registration' do
    email = "fresh_baked_honeybun@healthyicing.gov"
    first_name = "Davoin"
    last_name = "Shower Handle"
    password_confirmation = "password"

    # When I visit "/"
    visit "/"

    # And I click "Register"
    click_link "Register"

    # Then I should be on "/register"
    expect(current_path).to eq(register_path)

    # And when I fill in an email address (required)
    fill_in :user_email, with: email
    # And I fill in first name (required)
    fill_in :user_first_name, with: first_name
    # And I fill in first name (required)
    fill_in :user_last_name, with: last_name
    # And I fill in password and password confirmation (required)
    fill_in :user_password, with: password_confirmation
    fill_in :user_password_confirmation, with: password_confirmation

    # And I click submit
    click_button "Create Account"

    # Then I should be redirected to "/dashboard"
    expect(current_path).to eq(dashboard_path)

    # And I should see a message that says "Logged in as <SOME_NAME>"
    expect(page).to have_content "Logged in as #{first_name}"

    # And I should see a message that says "This account has not yet been activated. Please check your email."
    expect(page).to have_content "This account has not yet been activated. Please check your email."
  end
end
