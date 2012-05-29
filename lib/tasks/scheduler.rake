desc "This task is called by the Heroku scheduler add-on"
task :get_tweets => :environment do
    puts "Getting users"
    Tweet.get_tweets
    puts "done."
end