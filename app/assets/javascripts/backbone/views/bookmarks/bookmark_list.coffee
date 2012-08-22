class window.BookmarkListView extends Backbone.View

  events: null

  initialize: (options) ->
    @render()

  render: ->
    console.log(bookmark, @collection)
    for bookmark in @collection.models
      console.log(bookmark)
      bookmarkHtml = new BookmarkListItemView(
        model: bookmark
      ).render()
      @$el.append(bookmarkHtml)
    @

  viewData: ->
    bookmarks: @collection.models
