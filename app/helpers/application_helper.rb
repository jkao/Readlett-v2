module ApplicationHelper
  READLETT_QUOTE = "Bookmarking made Simple"
  WALLPAPER_COUNT = 1

  # Set title of layout page
  def title(page_title)
    content_for(:title) { page_title }
  end

  def wallpaper_id
    "wallpaper-#{rand(WALLPAPER_COUNT) + 1}"
  end

end
