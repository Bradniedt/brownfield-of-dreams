require 'rails_helper'

describe "An Admin can delete a tutorial" do
  it 'destroys videos belonging to the tutorial that was deleted' do
    tutorial_1 = create(:tutorial)
    video = create(:video, tutorial: tutorial_1)
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Destroy"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to_not have_content("#{video.title}")
    expect(Video.first).to eq(nil)
    end
  end
