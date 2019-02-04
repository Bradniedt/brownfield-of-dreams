class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial


  def self.get_bookmarks(id)
    select("videos.*")
    .joins(:user_videos)
    .order(:tutorial_id)
    .where("user_videos.user_id = ?", "#{id}")
  end
end
