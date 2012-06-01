# == Schema Information
#
# Table name: tweets
#
#  id           :integer         not null, primary key
#  created_at   :string(255)     not null
#  text         :string(255)
#  hashtags     :string(255)
#  urls         :string(255)
#  user_id      :integer
#  updated_at   :datetime        not null
#  tweetid      :integer
#  extended_url :text(255)
#  site_title   :string(255)
#

require 'spec_helper'

describe Tweet do
  pending "add some examples to (or delete) #{__FILE__}"
end
