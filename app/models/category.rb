class Category < ActiveRecord::Base
  has_many :bookmarks

  # Can treat attributes as symbols
  symbolize :code
  symbolize :name

  def get_latest_bookmarks(lim = 16)
    self.bookmarks.order("id DESC").limit(lim)
  end
end
