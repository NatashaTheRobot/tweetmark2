class TweetsController < ApplicationController
   def create
       
       @user = User.find(session[:user_id])

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
                       :urls => url_array[0] } #only the first url is stored
            hashtag_array = tweet["entities"]["hashtags"]
            p params
            newtweet = Tweet.new(params)
            newtweet.save

            #adding hashtags
            if hashtag_array != [] and newtweet.id != nil
                hashtag_array.each do |hashtag_hash| 
                    text = hashtag_hash["text"]
                    hashtag = Hashtag.new({:text => text, :tweet_id => newtweet.id})
                    hashtag.save 
                end
            end
        end
   end
   
   def update

          @user = User.find(session[:user_id])

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
                          :urls => url_array[0] } #only the first url is stored
               hashtag_array = tweet["entities"]["hashtags"]
               p params
               newtweet = Tweet.new(params)
               newtweet.save

               #adding hashtags
               if hashtag_array != [] and newtweet.id != nil
                   hashtag_array.each do |hashtag_hash| 
                       text = hashtag_hash["text"]
                       hashtag = Hashtag.new({:text => text, :tweet_id => newtweet.id})
                       hashtag.save 
                   end
               end
           end
      end
end