require 'rails_helper'

describe 'As a visitor' do
  context 'can see tutorials' do
    it 'when they are not classroom content' do
      tutorial_1 = create(:tutorial, classroom: true)
      tutorial_2 = create(:tutorial, classroom: false)
      tutorial_3 = create(:tutorial, classroom: false)
      video_1 = create(:video, tutorial: tutorial_1)
      video_2 = create(:video, tutorial: tutorial_2)
      video_3 = create(:video, tutorial: tutorial_3)

      visit '/'

      expect(page).to_not have_link(tutorial_1.title)
      within '.tutorials' do
        expect(page).to have_link(tutorial_2.title)
        expect(page).to have_link(tutorial_3.title)
      end
    end
    it 'when they visit a tutorial show page for a tutorial without a video' do
      tutorial_1 = create(:tutorial, classroom: false)

      visit tutorial_path(tutorial_1)
      
      expect(page).to have_content("This tutorial does not have any videos yet.")
    end
  end
end
