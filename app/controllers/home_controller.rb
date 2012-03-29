class HomeController < MainSiteController

  caches_page :index, :about, :legal

  def index
  end

  def about
  end

  def legal
  end

end
