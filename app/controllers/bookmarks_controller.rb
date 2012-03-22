class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.page(params[:page]).order("id DESC")
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def filter
  end

end
