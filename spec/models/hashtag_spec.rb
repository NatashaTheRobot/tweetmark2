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

require 'spec_helper'

describe Hashtag do
  pending "add some examples to (or delete) #{__FILE__}"
end
