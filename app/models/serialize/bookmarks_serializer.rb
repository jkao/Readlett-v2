class Serialize::BookmarksSerializer
  def self.as_json(bookmarks)
    if bookmarks.nil? || bookmarks.empty?
      {}
    else
      bookmarks.map { |bookmark|
        Serialize::BookmarkSerializer.as_json(bookmark)
      }
    end
  end
end
