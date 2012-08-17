class window.MyBookmarksBookmarkView extends Backbone.View
  # TODO
  #events:
  #"" : ""

  initialize: (options) ->
    @render()

  render: ->
    bookmarkHtml = JST["#{window.TEMPLATES}/users/my_bookmarks/bookmark"](bookmark: @model)
    @$el.append(bookmarkHtml)
    @
