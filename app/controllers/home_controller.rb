class HomeController < MainSiteController

  caches_page :index, :about, :faq

  def index
    @bookmarks = Bookmark.get_recent.page(params[:page])
  end

  def about
  end

  def faq
  end

end
