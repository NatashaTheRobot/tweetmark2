# == Schema Information
#
# Table name: tweets
#
#  id         :integer         not null, primary key
#  created_at :string(255)     not null
#  text       :string(255)
#  hashtags   :string(255)
#  urls       :string(255)
#  user_id    :integer
#  updated_at :datetime        not null
#  tweetid    :integer
#

class Tweet < ActiveRecord::Base
  attr_accessible :created_at, :hashtags, :text, :urls, :user_id, :tweetid
  validates :tweetid, uniqueness: true
  belongs_to :user
end
