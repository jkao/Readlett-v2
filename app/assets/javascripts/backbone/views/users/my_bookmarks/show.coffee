class window.ShowMyBookmarksView extends Backbone.View

  MIN_SEARCH_LENGTH = 0

  events:
    "keyup input.search" : "filterBookmarks"

  initialize: ->
    @render()

  render: ->
    renderBk = @renderBookmarks
    @$el.fadeOut( ->
      # Show the General Layout
      $(this).html(JST["#{window.TEMPLATES}/users/my_bookmarks/show"])
      $(".bookmarks:first").html("<div class='span9 loading'>&nbsp;</div>")
      $(this).fadeIn()

      # Load the Bookmarks
      $.get("/users/#{window.userObject.id}/bookmarks", (resp) =>
        renderBk(resp)
      )
    )
    @

  renderBookmarks: (resp) =>
    bookmarksEl = $(".bookmarks:first")

    if resp.length > 0
      bookmarksEl.html("")
      _.each(resp, (bookmark) =>
        bookmarkEl = new MyBookmarksBookmarkView({
          model: bookmark,
          mode: "show"
        }).render()
        bookmarksEl.append(bookmarkEl)
      )
    else
      bookmarksEl.html("<div class='row blue-notification'><div class='span9'><h4>Oops, looks like you don't have any bookmarks. Start saving some with the Bookmarklet!</h4></div></div>")
    @

  filterBookmarks: ->
    # Trim and Refine the Search Terms
    searchVal = $("input.search").val().replace /^\s+|\s+$/g, ""

    # Do the Search if Above the Constraint
    if searchVal.length >= MIN_SEARCH_LENGTH
      $(".bookmark").trigger("search:bookmarks", searchVal)
    else
      $(".bookmark").trigger("show:bookmarks", searchVal)
