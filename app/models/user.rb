class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

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

  def self.user_check(name)
    User.find_by(githubname: name)
  end

  def friend_check(name)
    return false if User.user_check(name).nil?
    friend = User.user_check(name)
    friends.include?(friend)
  end

  def add_friend(name)
    new_friend = User.user_check(name)
    Friendship.create(user: self, friend: new_friend)
  end
end
