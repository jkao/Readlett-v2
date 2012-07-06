class window.HomeRouter extends Backbone.Router
  routes:
    'bookmark/:id' : 'bookmark'

  bookmark: (id) ->
    alert("bookmark #{id}")

  initializeRecentBookmarksFeed: ->
    @bookmarkList = new BookmarkListView({
      el: '#recent-bookmarks'
      collection: new Bookmarks($('#recent-bookmarks').data('bookmarks'))
    })
    @
