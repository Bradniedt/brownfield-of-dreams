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
  end
end
