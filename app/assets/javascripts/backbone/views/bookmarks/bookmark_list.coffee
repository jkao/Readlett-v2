class window.BookmarkListView extends Backbone.View

  events: {} # TODO

  initialize: (options) ->
    @render()

  render: ->
    for bookmark in @collection.models
      bookmarkDiv = $("<div>").attr("id", "bookmark-#{bookmark.attributes.id}")
      @$el.append(bookmarkDiv)

      new BookmarkListItemView(
        el: bookmarkDiv
        model: bookmark
      )
    @

  viewData: ->
    bookmarks: @collection.models
