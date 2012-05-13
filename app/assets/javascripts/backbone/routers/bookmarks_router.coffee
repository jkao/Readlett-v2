class window.ExploreRouter extends Backbone.Router
  routes:
    ''      : 'bookmarks'
    ':page' : 'bookmarks'
    'b/:id' : 'bookmark'

  bookmarks: (page) ->
    console.log(page)

  bookmark: (id) ->
    console.log(id)

