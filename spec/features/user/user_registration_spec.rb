require 'rails_helper'

describe 'A visitor to our app' do
  it 'registration' do
    clear_emails
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.find_by(email: "fresh_baked_honeybun@healthyicing.gov"))

    open_email('fresh_baked_honeybun@healthyicing.gov')
    expect(current_email).to have_content "Visit this link to activate your account."

    current_email.click_link 'Activate'

    expect(page).to have_content "Thank you! Your account is now activated!"

    visit dashboard_path

    expect(page).to have_content "Status: Active" #titlecase in the view or in controller.

  end
end
