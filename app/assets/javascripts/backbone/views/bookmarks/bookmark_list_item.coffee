class window.BookmarkListItemView extends Backbone.View

  BOOKMARK_LIST_ITEM = "bookmarks/bookmark_list_item"

  events: {
    #"click .bookmark[data-id='#{@model.attributes.id}'] li.save" : 'saveBookmark'
    #"click .bookmark[data-id='#{@model.attributes.id}'] li.share" : 'shareBookmark'
    "click .bookmark li.save" : 'saveBookmark'
    "click .bookmark li.share" : 'shareBookmark'
  }

  initialize: (options) ->
    @render()

  render: ->
    @$el.html(JST["#{TEMPLATES}/#{BOOKMARK_LIST_ITEM}"](@viewData()))

  saveBookmark: ->
    alert('save' + @model.attributes.id)
    false

  shareBookmark: ->
    alert('share' + @model.attributes.id)
    false

  viewData: ->
    bookmark: @model
