class BookmarksSerializer
  def self.as_json(bookmarks)
    if bookmarks.empty?
      {}
    else
      bookmarks.map { |bookmark|
        BookmarkSerializer.as_json(bookmark)
      }
    end
  end
end
