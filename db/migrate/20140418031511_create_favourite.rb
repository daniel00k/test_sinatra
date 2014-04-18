class CreateFavourite < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
