namespace :nillify do
  desc "Video"
  task video_positions: :environment do
    Video.update_all(position: nil)
  end
end
