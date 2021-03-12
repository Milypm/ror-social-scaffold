class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  def confirm_friend(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: id)
    friendship.confirmed = true
    friendship.save
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def decline_friendship(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: id)
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
