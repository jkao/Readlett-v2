class window.BookmarkListItemView extends Backbone.View

  BOOKMARK_LIST_ITEM = "bookmarks/bookmark_list_item"

  events: {} # TODO

  initialize: (options) ->
    @render()

  render: ->
    @$el.html(JST["#{TEMPLATES}/#{BOOKMARK_LIST_ITEM}"](@viewData()))
    @

  viewData: ->
    bookmark: @model
