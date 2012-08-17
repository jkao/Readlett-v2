class UsersController < ApplicationController
  include ApiResponseLibrary

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

  # TODO:
  # Figure out Business Logic for Permissions of Bookmarks
  # We probably want to allow this and filter out private/nsfw ones
  # if you're not the user
  def bookmarks
    @user = User.find(params[:id])

    render :status => 404 and return if @user.nil?

    # Grab Bookmarks and Render Them Out
    @bookmarks = @user.current_bookmarks
    render_collection_json Serialize::BookmarksSerializer.as_json_with_current_entries(@bookmarks, @user)
  end

  def settings
  end

  def update_bookmark_position
    @bookmark = Bookmark.find(params[:bookmark_id])
    current_user.update_bookmark_position(@bookmark, params[:new_url])
  end

end

