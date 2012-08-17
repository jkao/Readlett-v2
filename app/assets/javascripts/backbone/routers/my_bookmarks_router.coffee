class window.MyBookmarksRouter extends Backbone.Router
  routes:
    ''        : 'showBookmarks'
    'create'  : 'createBookmark'
    'update'  : 'updateBookmarks'

  showBookmarks: ->
    # Load Menu
    @changeMenuView("show")

    # Load Content
    new ShowMyBookmarksView({
      el: "#content"
    })

  createBookmark: ->
    # Load Menu
    @changeMenuView("add")

    # Load Content
    contentEl = $("#content")
    new NewBookmarkView({
      el: contentEl,
      url: contentEl.data("url")
    })

  updateBookmarks: ->
    # Load Menu
    @changeMenuView("up")

    # Load Content
    contentEl = $("#content")
    new UpdateMyBookmarksView({
      el: contentEl,
      url: contentEl.data("url")
    })

  changeMenuView: (selectedMenuOption) ->
    new MyBookmarksMenuView({
      el: "#menu"
      selectedEl: "##{selectedMenuOption}"
    })
    @
