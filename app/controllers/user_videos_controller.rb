class UserVideosController < ApplicationController
  def new
  end

  def create
    user_video = UserVideo.new(user_video_params)
    bookmark_exists(user_video) ? notify : confirm(user_video)
    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def bookmark_exists(user_video)
    return true if current_user.user_videos.find_by(video_id: user_video.video_id)
  end

  def notify
    flash[:error] = "Already in your bookmarks"
  end

  def confirm(user_video)
    if user_video.save
      flash[:success] = "Bookmark added to your dashboard!"
    end
  end
end
