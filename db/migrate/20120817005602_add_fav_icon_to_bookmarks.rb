class AddFavIconToBookmarks < ActiveRecord::Migration
  def up
    add_column :bookmarks, :favicon, :string
  end

  def down
    remove_column :bookmarks, :favicon
  end
end
