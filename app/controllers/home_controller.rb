class HomeController < MainSiteController

  caches_page :index, :about, :legal

  def index
    @bookmarks = Bookmark.get_recent
  end

  def about
  end

  def legal
  end

end
