class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.page(params[:page]).order("id DESC")
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @bookmark.increment_view! unless @bookmark.nil?
  end

  def create
  end

  def update
  end

  def filter
  end

end
