class HashtagsController < ApplicationController
    def hashtag
        @user = User.find(session[:user_id])
        
        #find tweet ids where Hashtag.text is the same
        #find tweets by the specified tweet id 
        
        #get all tweets 
        all_tweets = @user.tweets
        all_tweetids = []
        all_tweets.each do |tweet|
           all_tweetids << tweet.id 
        end
        
        #get all hashtags
        @all_hashtags = Hash.new #{hashtag-text1 => [tweetid1, tweetid2], hashtag-text2 => [tweetid3, tweeetid4] }
        hashtags = Hashtag.where(:tweet_id => all_tweetids)
        if hashtags != []
            hashtags.each do |hashtag|
                if @all_hashtags.has_key?(hashtag[:text])
                    @all_hashtags[hashtag[:text]] << hashtag[:tweet_id]
                else
                    @all_hashtags[hashtag[:text]] = [hashtag[:tweet_id]]
                end
            end
        end
        
        #find all tweets with specific hashtags
        @tweets = all_tweets.where(:id => @all_hashtags[params[:hashtag]]) #matches ids for specific hashtag text
        
        render "static_pages/home"
    end
end
