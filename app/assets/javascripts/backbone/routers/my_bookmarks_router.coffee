class window.MyBookmarksRouter extends Backbone.Router
  routes:
    ''        : 'showBookmarks'
    'create'  : 'createBookmark'
    'update'  : 'updateBookmarks'

  showBookmarks: ->
    @changeMenuView("show")

  createBookmark: ->
    # Load Menu
    @changeMenuView("add")

    # Load Content Section
    contentEl = $("#content")
    new NewBookmarkView({
      el: contentEl,
      url: contentEl.data("url")
    })

  updateBookmarks: ->
    @changeMenuView("up")

  changeMenuView: (selectedMenuOption) ->
    new MyBookmarksMenuView({
      el: "#menu"
      selectedEl: "##{selectedMenuOption}"
    })
    @

  # TODO
  changeContentView: () ->
    @
