class window.BookmarkListView extends Backbone.View

  events: {} # TODO

  initialize: (options) ->
    @render()

  render: ->
    for bookmark in @collection.models
      new BookmarkListItemView(
        el: @$el
        model: bookmark
      )
    @

  viewData: ->
    bookmarks: @collection.models
