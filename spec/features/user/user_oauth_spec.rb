require 'rails_helper'

describe 'User Oauth' do
  it 'can see the link to connect to github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    save_and_open_page

    expect(page).to have_button('Connect to Github')
  end
end
