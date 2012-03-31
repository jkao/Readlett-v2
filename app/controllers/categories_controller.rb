class CategoriesController < ApplicationController
  def index
    @categories = Category.all # TODO: Paginate
  end

  def query
    @category = Category.where(:name => params[:query])
    @bookmarks = @category.nil? ? nil : @category.bookmarks
  end
end
