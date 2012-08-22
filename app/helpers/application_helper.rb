module ApplicationHelper
  MEDIAC_QUOTE = "Bookmarking made Simple"
  WALLPAPER_COUNT = 4

  # Set title of layout page
  def title(page_title)
    content_for(:title) { page_title }
  end

  def default_title
    MEDIAC_QUOTE
  end

  def wallpaper_id
    session[:wallpaper] ||= "wallpaper-#{rand(WALLPAPER_COUNT) + 1}"
    session[:wallpaper]
  end

  def bookmarklet_code
    BOOKMARKLET_CODE
  end

end
