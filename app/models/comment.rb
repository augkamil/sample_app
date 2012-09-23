class Comment < ActiveRecord::Base
  belongs_to :micropost
  attr_accessible :commenter, :content

  validates :content, presence: true, length: {maximum: 140}
end
