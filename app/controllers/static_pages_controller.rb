class StaticPagesController < ApplicationController
  def home
      unless session[:user_id].nil?
         #get the user's tweets and display them
         @user = User.find(session[:user_id])
         @tweets = @user.tweets
      end
  end

  def about
  end
end
