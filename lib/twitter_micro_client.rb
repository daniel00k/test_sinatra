require "twitter"
module TwitterMicroClient
  class Client
    attr_accessor :client
    ###########################################################################
    #
    # Use the five topics and the quantity created at the beggining and then
    # find tweets using the topics.
    #
    ###########################################################################
    def find_tweets
      @topics    =  Topic.all.limit(5).pluck(:name).join(" OR ")
      @quantity  =  Favorite.first.quantity
      @client    =  create_client
      response   =  @client.search(@topics, result_type: "recent").to_a
      @quantity.times{create_favorite_tweet response[Random.rand(response.length)] }
      check_new_followers
    end

    ###########################################################################
    #
    # tweet => A Twitter::Tweet Object
    # Use the tweet parameter to mark it as favorite and if the response
    # is success a new favorite twitter is created
    #
    ###########################################################################
    def create_favorite_tweet tweet
      response = client.favorite tweet.id
      if response.first.is_a? Twitter::Tweet
        FavoriteTweet.create tweet_id: tweet.id,
                              tweeted_by_username: tweet.user.screen_name,
                              tweeted_by_user_picture: tweet.user.profile_image_url.to_s,
                              tweeted_by_user_id: tweet.user.id,
                              body: tweet.text
      end
    end

    ###########################################################################
    #
    # When the topics and the quantity are setted, loads all the followers
    # and set the :first_load flag.
    #
    ###########################################################################
    def load_followers!
      c = create_client
      c.followers.each do |f|
        Follower.create user_id: f.id,
                        user_name: f.screen_name,
                        user_picture: f.profile_image_url.to_s,
                        first_load: true
      end
    end

    ###########################################################################
    #
    #Loops through the followers and creates a new follower if finds a new one
    #
    ###########################################################################
    def check_new_followers
      client.followers.each do |f|
        unless Follower.where(user_id: f.id.to_s).first
          Follower.create user_id: f.id,
                        user_name: f.screen_name,
                        user_picture: f.profile_image_url.to_s
        end
      end
    end
    ###########################################################################
    #
    #Creates the twitter client using the twitter credentials
    #
    ###########################################################################
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