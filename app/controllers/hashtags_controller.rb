class HashtagsController < ApplicationController
    def hashtag
        
        @user = User.find(session[:user_id])
        
        #get all tweets 
        all_tweets = @user.tweets
        all_tweetids = []
        all_tweets.each do |tweet|
           all_tweetids << tweet.id 
        end
        
        #if the tweet has no hashtag
        if params[:hashtag] = "notag"
            #get all tweet ids that have a hashtag
               tweetids_with_hashtags = []
               hashtags = Hashtag.where(:tweet_id => all_tweetids)
               if hashtags != []
                  hashtags.each do |hashtag|
                      tweetids_with_hashtags << hashtag[:tweet_id] unless tweetids_with_hashtags.include?(hashtag[:tweet_id])
                  end 
               end

               #get tweet ids without a hashtag
               tweetids_with_no_hashtags = all_tweetids - tweetids_with_hashtags

               @tweets = all_tweets.where(:id => tweetids_with_no_hashtags)
               
        else #tweets with hashtags
        
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
        
        end
        render "static_pages/home"
    end
end
