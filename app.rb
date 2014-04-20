require "sinatra"
require "sinatra/activerecord"
require 'sinatra/contrib'
Dir.glob('lib/*.rb').each { |r| load r}
class Topic < ActiveRecord::Base
end
class Favorite < ActiveRecord::Base
end
class FavoriteTweet < ActiveRecord::Base
end
class Follower < ActiveRecord::Base
  def self.by_favorite
    find_by_sql("select followers.* from followers join favorite_tweets on favorite_tweets.tweeted_by_user_id=followers.user_id where followers.first_load IS FALSE")
  end
end
set :port, 3000
set :bind, '0.0.0.0'
get "/" do
  @topics = Topic.all
  erb :"topics/index"
end

post '/topics' do
  words_array = (params[:topic][:words]).split(",")
  words_array.each{|w| Topic.create(name: w)}
  Favorite.create(quantity: params[:topic][:quantity])
  TwitterMicroClient::Client.new.load_followers!
  redirect "/"
end

get '/followers', :provides => [:json] do
  @followers = Follower.all

  respond_to do |format|
    format.json { @followers.to_json }
  end
end
get '/favorites', :provides => [:json] do
  @favorites = FavoriteTweet.all

  respond_to do |format|
    format.json { @favorites.to_json }
  end
end