class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def add_github(auth_hash)
    token = auth_hash["credentials"]["token"]
    update!(token: "#{token}")
    update!(githubname: auth_hash["nickname"])
  end

  def repos(token)
    Repo.find_all(token)
  end

  def followers(token)
    Follower.find_all(token)
  end

  def following(token)
    Following.find_all(token)
  end

end
