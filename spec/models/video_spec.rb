require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'class method' do
    it '.get_bookmarks' do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      tutorial_3 = create(:tutorial)
      video_1 = create(:video, position: 1, tutorial: tutorial_1)
      video_2 = create(:video, position: 3, tutorial: tutorial_3)
      video_3 = create(:video, position: 2, tutorial: tutorial_2)
      video_4 = create(:video)
      user_1 = create(:user)
      user_video_1 = UserVideo.create(user: user_1, video: video_1)
      user_video_2 = UserVideo.create(user: user_1, video: video_2)
      user_video_3 = UserVideo.create(user: user_1, video: video_3)

      expect(Video.get_bookmarks(user_1.id)[0]).to eq(video_1)
      expect(Video.get_bookmarks(user_1.id)[1]).to eq(video_3)
      expect(Video.get_bookmarks(user_1.id)[2]).to eq(video_2)
      expect(Video.get_bookmarks(user_1.id)).to eq([video_1, video_3, video_2])
    end
  end

end
