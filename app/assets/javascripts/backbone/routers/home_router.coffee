class window.HomeRouter extends Backbone.Router
  routes:
    'bookmark/:id' : 'bookmark'

  bookmark: (id) ->
    alert("bookmark #{id}")

  initializeRecentBookmarksFeed: ->
    @bookmarkList = new BookmarkListView({
      el: '#recent-bookmarks' # TODO: Test without jQuery selector
      collection: new Bookmarks($('#recent-bookmarks').data('bookmarks'))
    })
    @
