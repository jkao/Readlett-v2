class HomeController < MainSiteController

  def index
    @bookmarks = Bookmark.get_recent.page(params[:page])
  end

  def explore
    @tags = Tag.get_popular
    @bookmarks = Bookmark.get_popular.page(params[:page])
  end

  def about
  end

  def faq
  end

end
