require "twitter"
module TwitterMicroClient
  class Client
    attr_accessor :client
    def find_tweets
      @topics    =  Topic.all.limit(5).pluck(:name).join(",")
      @quantity  =  favorite.first.quantity
      @client    =  create_client
      response   =  @client.search(@topics).to_a
      @quantity.times{|q| create_favorite_tweet response[Random.rand(response.length)] }
      check_new_followers
    end

    def create_favorite_tweet tweet
      response = client.favorite tweet.id
      if response.first.is_a? Twitter::Tweet
        favoriteTweet.create tweet_id: tweet.id,
                              tweeted_by_username: tweet.user.screen_name,
                              tweeted_by_user_picture: tweet.user.profile_image_url.to_s,
                              tweeted_by_user_id: tweet.user.id,
                              body: tweet.text
      end
    end

    def load_followers!
      c = create_client
      c.followers.each do |f|
        Follower.create user_id: f.id,
                        user_name: f.screen_name,
                        user_picture: f.profile_image_url.to_s,
                        first_load: true
      end
    end

    def check_new_followers
      client.followers.each do |follower|
        unless Follower.where(user_id: follower.id).first
          Follower.create user_id: f.id,
                        user_name: f.screen_name,
                        user_picture: f.profile_image_url.to_s
        end
      end
    end

    def create_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = "7DtOD39lNcuX0XXCIkBabtiLj"
        config.consumer_secret     = "nSmLpP4Ozqt8fYRqLRYIVMpt2ZuqJjcfQu2K5MOLTc006WbcWt"
        config.access_token        = "151253966-cIkqPc146PGykgQf5bFoDdyw2NpYpwPNHJqPHFvI"
        config.access_token_secret = "yDyXPCur2WnIcUlbScZSvSdbdYKw7EBD6jTvAwV4kYh8k"
      end
    end
  end
end