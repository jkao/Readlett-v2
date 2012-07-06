class window.BookmarkListView extends Backbone.View

  events: {} # TODO

  initialize: (options) ->
    @render()
    @initializeMasonry()

  initializeMasonry: ->
    @$el.masonry(
      itemSelector: ".bookmark-box"
    )

  render: ->
    for bookmark in @collection.models
      bookmarkDiv = $("<span>").attr("id", "bookmark-#{bookmark.attributes.id}")
                               .addClass("bookmark-box")
      @$el.append(bookmarkDiv)

      new BookmarkListItemView(
        el: bookmarkDiv
        model: bookmark
      )
    @

  viewData: ->
    bookmarks: @collection.models
