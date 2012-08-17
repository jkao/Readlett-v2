class BookmarksController < ApplicationController
  include ApiResponseLibrary

  BOOKMARK_PRIVACY_CHECK_MEMBERS = [:index, :search, :create, :popular]

  before_filter :auth_check, :except => [:index, :show, :search, :redirect, :popular, :share, :report]
  before_filter :load_bookmark_from_params, :except => BOOKMARK_PRIVACY_CHECK_MEMBERS
  before_filter :bookmark_privacy_check, :except => BOOKMARK_PRIVACY_CHECK_MEMBERS

  def index
    @bookmarks = Bookmark.safe_query.get_recent.page(params[:page])
    render_collection_json Serialize::BookmarksSerializer.as_json(@bookmarks, current_user)
  end

  def search
    @bookmarks = Bookmark.search(params[:query]).page(params[:page])
    render_collection_json Serialize::BookmarksSerializer.as_json(@bookmarks, current_user)
  end

  def popular
    @bookmarks = Bookmark.get_popular.page(params[:page])
    render_collection_json Serialize::BookmarksSerializer.as_json(@bookmarks, current_user)
  end

  def show
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def create
    @bookmark = Bookmark.new

    begin
=begin
      # TODO: Uncomment when you have proper internet
      site = MetaInspector.new(params[:url])

      @bookmark.url = site.url
      @bookmark.title = site.title
      @bookmark.description = site.description
=end
      # Set the Bookmark Parameters
      @bookmark.url = params[:url]
      @bookmark.title = "TEST SITE #{UUID.generate(:compact)}"
      @bookmark.description = "TEST DESCRIPTION #{UUID.generate(:compact)}"
      @bookmark.user = current_user

      if @bookmark.save # Follow & Tag It
        @bookmark.follow!(current_user)

        params[:tags].each do |tag|
          tag_obj = Tag.create_or_use_unique_tag(tag)
          @bookmark.tags << tag_obj
        end
      end

    rescue Exception => e
      puts e.inspect
      @bookmark.errors[:base] << "The site you've entered appears to be unavailable or our service is down :("
      Rails::logger.warn "#{Time.now}: Invalid URL: #{e.inspect} User: #{current_user.inspect} Bookmark: #{@bookmark.inspect}"
    end

    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def update
    @bookmark.update_attributes(bookmark_params)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def destroy
    @bookmark.safe_delete(current_user)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def like
    @bookmark.like!(current_user)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def unlike
    @bookmark.unlike!(current_user)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def follow
    @bookmark.follow!(current_user)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def unfollow
    @bookmark.unfollow!(current_user)
    render_json Serialize::BookmarkSerializer.as_json(@bookmark, current_user)
  end

  def redirect
    @bookmark.increment_view!
    redirect_to @bookmark.url
  end

  def share
    render :layout => "share"
  end

  def report
    @bookmark.set_complaint(params[:complainer_id], params[:reason])
    render :status => 200, :nothing => true
  end

  private

  def load_bookmark_from_params
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_privacy_check
    render :status => 404 and return unless @bookmark && @bookmark.user_can_see?(current_user)
  end

  # Prevent mass-assignment exploits
  def bookmark_params
    params[:bookmark].slice(:title, :description, :url, :private, :nsfw)
  end

end
