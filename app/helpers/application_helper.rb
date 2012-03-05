module ApplicationHelper
  READLETT_QUOTE = "Bookmarking made Simple"

  # Set title of layout page
  def title(page_title)
    content_for(:title) { page_title }
  end

end
