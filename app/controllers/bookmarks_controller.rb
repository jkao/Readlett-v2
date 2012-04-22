class BookmarksController < ApplicationController

  BOOKMARK_PRIVACY_CHECK_MEMBERS = [:index, :search, :create, :popular]

  before_filter :auth_check, :except => [:index, :show, :search, :redirect, :popular]
  before_filter :load_bookmark_from_params, :except => BOOKMARK_PRIVACY_CHECK_MEMBERS
  before_filter :bookmark_privacy_check, :except => BOOKMARK_PRIVACY_CHECK_MEMBERS

  def index
    @bookmarks = Bookmark.safe_query.get_recent.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render :json => Serialize::BookmarksSerializer.as_json(@bookmarks) }
    end
  end

  def search
    @bookmarks = Bookmark.search(params[:query]).page(params[:page])
    render :json => Serialize::BookmarksSerializer.as_json(@bookmarks)
  end

  def popular
    @bookmarks = Bookmark.get_popular.page(params[:page])
    render :json => Serialize::BookmarksSerializer.as_json(@bookmarks)
  end

  def show
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    @bookmark.follow!(current_user) if @bookmark.save
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def update
    @bookmark.update_attributes(bookmark_params)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def destroy
    @bookmark.safe_delete(current_user)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def like
    @bookmark.like!(current_user)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def unlike
    @bookmark.unlike!(current_user)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def follow
    @bookmark.follow!(current_user)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def unfollow
    @bookmark.unfollow!(current_user)
    render :json => Serialize::BookmarkSerializer.as_json(@bookmark)
  end

  def redirect
    @bookmark.increment_view!
    redirect_to @bookmark.url
  end

  private

  def load_bookmark_from_params
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_privacy_check
    render 404 and return unless @bookmark && @bookmark.user_can_see?(current_user)
  end

  # Prevent mass-assignment exploits
  def bookmark_params
    params[:bookmark].slice(:title, :description, :url, :private, :nsfw)
  end

end
