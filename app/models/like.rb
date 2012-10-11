class Like < ActiveRecord::Base
  attr_accessible :liker_id, :liked_micropost_id
  belongs_to :user
  belongs_to :micropost
end
