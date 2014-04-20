namespace :twitter do
  desc "Gets info from the twitter API"
  task :get_info do
    TwitterMicroClient::Client.new.find_tweets
  end
end