# == Schema Information
#
# Table name: hashtags
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  tweet_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Hashtag < ActiveRecord::Base
  attr_accessible :text, :tweet_id
  belongs_to :tweet
end
