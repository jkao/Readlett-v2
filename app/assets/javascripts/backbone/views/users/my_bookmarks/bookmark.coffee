class window.MyBookmarksBookmarkView extends Backbone.View

  MIN_SEARCH_LENGTH = 0

  events:
    "search:bookmarks"  : "filterBookmark"
    "show:bookmarks"    : "show"
    "click a.trash"    : "unsaveBookmark"

  initialize: (options) ->
    @render()

  render: ->
    @$el.html(JST["#{window.TEMPLATES}/users/my_bookmarks/bookmark"](bookmark: @model))

  filterBookmark: (e, searchVal) ->
    if !searchVal or searchVal.length < MIN_SEARCH_LENGTH
      return @show()

    searchValRegExp = new RegExp(searchVal, "i")

    if searchValRegExp.test(@model.title) or
       searchValRegExp.test(@model.description) or
       searchValRegExp.test(@model.current_entry_url) or
       searchValRegExp.test(@model.url)
      @show()
    else
      @hide()

  hide: ->
    @$el.hide()

  show: ->
    @$el.show()

  unsaveBookmark: ->
    if confirm("Are you sure you want to unsave this bookmark? All tracked progress will be gone!")
      $.post("/bookmarks/#{@model.id}/unfollow",
        (res) =>
          @$el.fadeOut( ->
            $(this).destroy()
          )
          @undelegateEvents()
      ).error(->
        alert("An error occurred trying to unsave, please refresh your browser")
      )
    false
