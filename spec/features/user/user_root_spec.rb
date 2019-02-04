require 'rails_helper'

describe 'As a User' do
  context 'can see all tutorials' do
    it 'when I am logged in' do
      tutorial_1 = create(:tutorial, classroom: true)
      tutorial_2 = create(:tutorial, classroom: false)
      tutorial_3 = create(:tutorial, classroom: false)
      video_1 = create(:video, tutorial: tutorial_1)
      video_2 = create(:video, tutorial: tutorial_2)
      video_3 = create(:video, tutorial: tutorial_3)
      user = create(:user)

      visit '/'
      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/'

      within '.tutorials' do
        expect(page).to have_link(tutorial_1.title)
        expect(page).to have_link(tutorial_2.title)
        expect(page).to have_link(tutorial_3.title)
      end
    end
  end
end
