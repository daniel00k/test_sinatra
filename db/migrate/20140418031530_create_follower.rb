class CreateFollower < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer  :tweet_id
      t.integer  :user_id
      t.string   :user_name

      t.timestamps
    end
  end
end
