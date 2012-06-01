class StaticPagesController < ApplicationController
    def home
        unless session[:user_id].nil?
            #get the user's tweets and display them
            @user = User.find(session[:user_id])
            @tweets = @user.tweets  #"SELECT * FROM tweets WHERe user_id=#{user_id}"
            @tweets_count = @tweets.count
            @hashtags = Hash.new # {hashtag => count}
            if @tweets.length > 0
                @tweet_ids = []
                @tweets.each do |tweet|
                    @tweet_ids.push(tweet.id)
                end
                @tweetids_with_hashtags = []
                hashtags = Hashtag.where(:tweet_id => @tweet_ids)
                if hashtags != []
                    hashtags.each do |hashtag|
                        @tweetids_with_hashtags << hashtag[:tweet_id] unless @tweetids_with_hashtags.include?(hashtag[:tweed_id])
                        if @hashtags.has_key?(hashtag[:text])
                            @hashtags[hashtag[:text]] += 1 
                        else
                           @hashtags[hashtag[:text]] = 1
                        end
                    end
                end
            @hashtags = Hash[@hashtags.sort] #sort hashtags alphabetically 
            @untagged_tweet_count = (@tweet_ids - @tweetids_with_hashtags).length
            end
        end
    end

    def about
    end

end
