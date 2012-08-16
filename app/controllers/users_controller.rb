class UsersController < ApplicationController

  before_filter :auth_check, :except => [:show]

  def show
    @user = User.find(params[:id])
    @is_owner = current_user && current_user.id == params[:id]
  end

  def me
    @url = params[:url]
    @user = current_user
    @bookmarks = @user.current_bookmarks
  end

  def settings
  end

  def update_bookmark_position
    @bookmark = Bookmark.find(params[:bookmark_id])
    current_user.update_bookmark_position(@bookmark, params[:new_url])
  end

end

