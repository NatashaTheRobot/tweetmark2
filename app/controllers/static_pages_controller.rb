class StaticPagesController < ApplicationController
    def home
        unless session[:user_id].nil?
            #get the user's tweets and display them
            @user = User.find(session[:user_id])
            @tweets = @user.tweets  #"SELECT * FROM tweets WHERe user_id=#{user_id}"
            @hashtags = []
            @hashtags_count = Hash.new # {hashtag => count}
            if @tweets.length > 0
                tweet_ids = []
                @tweets.each do |tweet|
                    tweet_ids.push(tweet.id)
                end
                hashtags = Hashtag.where(:tweet_id => tweet_ids)
                if hashtags != []
                    hashtags.each do |hashtag|
                        @hashtags << hashtag[:text] unless @hashtags.include?(hashtag[:text])
                        unless @hashtags_count.has_key?(hashtag[:text])
                            @hashtags_count[hashtag[:text]] = 1 
                        else
                           @hashtags_count[hashtag[:text]] += 1
                        end
                    end
                end
            @hashtags.sort! #sort hashtags alphabetically    
            end
        end
    end

    def about
    end

end
