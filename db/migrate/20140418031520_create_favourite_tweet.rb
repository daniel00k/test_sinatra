class CreateFavouriteTweet < ActiveRecord::Migration
  def change
    create_table :favorite_tweets do |t|
      t.integer :tweet_id
      t.string  :body

      t.timestamps
    end
  end
end
