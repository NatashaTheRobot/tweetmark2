desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
    puts "Getting Tweets..."
    Tweet.get_tweets
    puts "done."
end