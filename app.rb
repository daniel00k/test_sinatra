require "sinatra"
require "sinatra/activerecord"
require './environments'
class Topic < ActiveRecord::Base
end
class Favourite < ActiveRecord::Base
end
class FavouriteTweet < ActiveRecord::Base
end
class Follower < ActiveRecord::Base
end

get "/" do
  @topics = Topic.all
  erb :"topics/index"
end

post '/topics' do
  words_array = (params[:topic][:words]).split()
  words_array.each{|w| Topic.create(name: w)}
  Favourite.create(quantity: params[:topic][:quantity])
  redirect "/"
end