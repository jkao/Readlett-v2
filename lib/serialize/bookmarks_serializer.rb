class Serialize::BookmarksSerializer
  def self.as_json(bookmarks, current_user=nil)
    if bookmarks.nil? || bookmarks.empty?
      {}
    else
      bookmarks.map { |bookmark|
        Serialize::BookmarkSerializer.as_json(bookmark, current_user)
      }
    end
  end

  def self.as_json_with_current_entries(bookmarks, current_user=nil)
    if bookmarks.nil? || bookmarks.empty?
      {}
    else
      bookmarks.map { |bookmark|
        Serialize::BookmarkSerializer.as_json_with_current_entries(bookmark, current_user)
      }
    end
  end
end
