class CreateFollower < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.float    :user_id
      t.string   :user_name
      t.string   :user_picture
      t.boolean  :first_load, default: false

      t.timestamps
    end
  end
end
