class AddLikesCacheColumn < ActiveRecord::Migration
  def up
    add_column :bookmarks, :likes_count, :integer, :default => 0
  end

  def down
    remove_column :bookmarks, :likes_count
  end
end
