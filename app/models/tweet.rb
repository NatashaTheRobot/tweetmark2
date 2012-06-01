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
#  site_title   :text(255)
#

class Tweet < ActiveRecord::Base
  attr_accessible :created_at, :hashtags, :text, :urls, :user_id, :tweetid, :extended_url, :site_title
  validates :tweetid, uniqueness: true
  belongs_to :user
  has_many :hashtags, dependent: :destroy
  
  def self.get_user_tweets(user)

         #get tweet info for user
         client = TwitterOAuth::Client.new(
                       :consumer_key => ENV['TWITTER_KEY'],
                       :consumer_secret => ENV['TWITTER_SECRET'],
                       :token => user[:auth_token],
                       :secret => user[:auth_secret]
                       )

          tweets = client.user_timeline({
                       "include_entities" => true, 
                       "include_rts" => true, 
                       "screen_name" => "#{user[:screen_name]}",
                       "count" => 200
                       })

          #get the users last 200 tweets and add to db
          tweets.each do |tweet|
              break if Tweet.find_by_tweetid(tweet["id"]) != nil
              url_array = tweet["entities"]["urls"]
              next if url_array == []  

              #adding tweet
              params = { :user_id => user['id'],
                         :created_at => tweet["created_at"],
                         :tweetid => tweet["id"],
                         :text => CGI.escape(tweet["text"]),
                         } 
              url_hash = url_array[0] #only the first url is stored
              url = url_hash["url"]
              extended_url = url_hash["expanded_url"]
              params[:extended_url] = extended_url
              params[:urls] = url            
              hashtag_array = tweet["entities"]["hashtags"]
              p params
              newtweet = Tweet.new(params)
              newtweet.save

              #adding hashtags
              if hashtag_array != [] and newtweet.id != nil
                  hashtag_array.each do |hashtag_hash| 
                      text = hashtag_hash["text"].downcase
                      hashtag = Hashtag.new({:text => text, :tweet_id => newtweet.id})
                      hashtag.save 
                  end
              end
          end
     end
     
     
     def self.get_tweets #scheduled daily task to get all user tweets
      
         #get user info
         users = User.all
         users.each do |user|
             self.get_user_tweets(user)
         end
     end
  
  def self.get_url_titles #gets titles for all the urls
      tweets = Tweet.all
      tweets.each do |tweet|
          break if tweet.site_title != nil
          begin
              html = open(tweet[:urls])
          rescue
              puts "Redirect not working!"
              tweet[:urls]
              next
          end
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'
          title = doc.at_css('title')
          unless title.nil? or title == ""
              tweet.site_title = CGI::escape(title.children.text.strip.gsub(/\n/, " "))
              tweet.save
          end 
      end 
   end

end
