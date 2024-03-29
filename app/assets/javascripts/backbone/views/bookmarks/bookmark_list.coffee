class window.BookmarkListView extends Backbone.View

  events: null

  initialize: (options) ->
    @render()

  render: ->
    for bookmark in @collection.models
      bookmarkHtml = new BookmarkListItemView(
        model: bookmark
      ).render()
      @$el.append(bookmarkHtml)
    @

  viewData: ->
    bookmarks: @collection.models
