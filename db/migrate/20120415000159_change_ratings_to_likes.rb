class ChangeRatingsToLikes < ActiveRecord::Migration
  def up
    rename_table :ratings, :likes
    remove_column :likes, :rating
  end

  def down
    rename_table :likes, :ratings
    add_column :ratings, :rating, :integer, :null => false
  end
end
