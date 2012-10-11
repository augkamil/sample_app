class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, foreign_key: "liked_micropost_id"
  has_many :likers, through: :likes, source: :liker

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  default_scope order: 'microposts.created_at DESC'

  def user_like_it(user)
    likes.create!(liker_id: user.id)
  end

  def user_dont_like_it(user)
    likes.find_by_liker_id(user.id).destroy
  end

  def like_count
  	self.likes.find_all.count
  end
end
