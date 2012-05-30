class StaticPagesController < ApplicationController
  def home
      unless session[:user_id].nil?

         #get the user's tweets and display them
         @user = User.find(session[:user_id])
         @tweets = @user.tweets
         @hashtags = []
         @tweets.each do |tweet|
             hashtags = Hashtag.where(:tweet_id => tweet.id)
             if hashtags != []
                 hashtags.each do |hashtag|
                     @hashtags << hashtag[:text] unless @hashtags.include?(hashtag[:text])
                 end
             end 
         end
     end
 end

  def about
  end
end
