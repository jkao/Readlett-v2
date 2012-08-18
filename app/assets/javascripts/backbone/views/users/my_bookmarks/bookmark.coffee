class window.MyBookmarksBookmarkView extends Backbone.View

  MIN_SEARCH_LENGTH = 0

  events:
    "search:bookmarks"  : "filterBookmark"
    "show:bookmarks"    : "show"
    "click a.trash"    : "unsaveBookmark"
    "mouseover .bookmark.row.hover" : "mouseOn" # Events for Updating
    "mouseout .bookmark.row.hover"  : "mouseOff"
    "click .bookmark.row.hover"  : "triggerUpdate"

  initialize: (options) ->
    @mode = options.mode
    @render()

  render: ->
    @$el.html(JST["#{window.TEMPLATES}/users/my_bookmarks/bookmark"](bookmark: @model, mode: @mode))

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

  # When Mouse is Over the Div, Replace the Colour
  mouseOn: ->
    @$(".hover").addClass("hovered")

  # When Mouse is Off the Div, Replace Original Content
  mouseOff: ->
    @$(".hover").removeClass("hovered")

  triggerUpdate: ->
    @$(".bookmark.row.hover").trigger("update:bookmark", @model.id)

