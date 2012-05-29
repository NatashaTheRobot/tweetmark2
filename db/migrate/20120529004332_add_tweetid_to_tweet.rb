class AddTweetidToTweet < ActiveRecord::Migration
  def change
      add_column :tweets, :tweetid, :bigint
  end
end
