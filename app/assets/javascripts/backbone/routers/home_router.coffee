class window.HomeRouter extends Backbone.Router
  routes:
    'bookmark/:id' : 'bookmark'

  bookmark: (id) ->
    alert("bookmark #{id}")

  initializeRecentBookmarksFeed: ->
    initialBookmarks = new Bookmarks($('#recent-bookmarks').data('bookmarks'))
    console.log(initialBookmarks)
    @

