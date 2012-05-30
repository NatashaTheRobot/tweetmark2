class StaticPagesController < ApplicationController
  def home
      unless session[:user_id].nil?

         #get the user's tweets and display them
         @user = User.find(session[:user_id])
         @tweets = @user.tweets
         @hashtags = []
         @tweets.each do |tweet|
             hashtag = Hashtag.find_by_tweet_id(tweet.id)
             if hashtag != nil
                 @hashtags << hashtag.text unless @hashtags.include?(hashtag)
             end 
         end
     end
 end

  def about
  end
end
