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
  
  def self.get_tweets
      
      #get user info
      users = User.all
      users.each do |user_hash|
          user = user_hash['user']   
      
          #get tweet info for each user
          client = TwitterOAuth::Client.new(
              :consumer_key => ENV['TWITTER_KEY'],
              :consumer_secret => ENV['TWITTER_SECRET'],
              :token => user['auth_token'],
              :secret => user['auth_secret']
              )

          tweets = client.user_timeline({
              "include_entities" => true, 
              "include_rts" => true, 
              "screen_name" => "#{user['screen_name']}",
              "count" => 200
              })
          
          #get the users last 200 tweets and add to db
          tweets.each do |tweet|
              break if Tweet.exists?(tweet["id"])
              url_array = tweet["entities"]["urls"]
              next if url_array == []  
              params = { :user_id => user['id'],
                          :created_at => tweet["created_at"],
                          :tweetid => tweet["id"],
                          :text => CGI.escape(tweet["text"]) }
              hashtag_array = tweet["entities"]["hashtags"]
              if hashtag_array != []
                  hashtags = ""  
                  hashtag_array.each do |hashtag_hash|
                      hashtags << "##{hashtag_hash["text"]}"
                  end
                  params[:hashtags] = hashtags
              end
              urls = ""
              url_array.each do |url_hash|
                  urls << url_hash["expanded_url"]
              end
              params[:urls] = urls #there might be multiple urls per tweet, seperated by http as delimeter 
              p params
              Tweet.new(params)
          end
      end
  end
end
