desc "This task is called by the Heroku scheduler add-on"
task :get_tweets => :environment do
    puts "Updating feed..."
    Tweet.get_tweets
    puts "done."
end