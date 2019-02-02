require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should have_many(:friendships)}
    it {should have_many(:friends)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe 'friendship methods' do
    it 'can check friendships' do
      user1 = create(:user)
      user2 = create(:user, githubname: "user2")
      user3 = create(:user)

      expect(User.user_check(user2.githubname)).to eq(user2)
      expect(user1.friend_check(user2.githubname)).to eq(false)

      user1.add_friend(user2.githubname)

      expect(user1.friend_check(user2.githubname)).to eq(true)
    end
  end
end
