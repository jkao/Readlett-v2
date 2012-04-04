class TagsController < ApplicationController

  # TODO: Return the most popular tags
  def index
    @categories = Tag.page(params[:page])
  end

  def show
    @tag = Tag.where(:name => params[:query])
  end

  def query
    @tag = Tag.where(:name => params[:query])
    @bookmarks = @tag.nil? ? nil : @tag.bookmarks
  end
end
