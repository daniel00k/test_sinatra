class CreateFavoriteTweet < ActiveRecord::Migration
  def change
    create_table :favorite_tweets do |t|
      t.integer :tweet_id
      t.string :tweeted_by_username
      t.string :tweeted_by_user_picture
      t.integer :tweeted_by_user_id
      t.string  :body

      t.timestamps
    end
  end
end
