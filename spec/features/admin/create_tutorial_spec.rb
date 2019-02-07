require 'rails_helper'

describe 'As an admin' do
  it 'can create a new tutorial' do
    admin = create(:admin)
    title = "How Not to Spill Honey On Your Legs"
    description = "Don't bring a lunchbox into the jungle."
    thumbnail = "https://bit.ly/2DWRTzm"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: title
    fill_in "tutorial[description]", with: description
    fill_in "tutorial[thumbnail]", with: thumbnail

    click_on "Save"
    
    expect(current_path).to eq(tutorial_path(Tutorial.first))
    expect(page).to have_content ("Successfully created tutorial.")

  end
end
