class RenameBookmarkLinkToUrl < ActiveRecord::Migration
  def change
    rename_column :bookmarks, :link, :url
  end
end
