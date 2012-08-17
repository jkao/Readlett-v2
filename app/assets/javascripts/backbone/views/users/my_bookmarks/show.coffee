class window.ShowMyBookmarksView extends Backbone.View

  events:
    "keyup input.search" : "filterBookmarks"
    "click button.search" : "filterBookmarks"

  initialize: ->
    @render()

  render: ->
    renderBk = @renderBookmarks
    @$el.fadeOut( ->
      # Show the General Layout
      $(this).html(JST["#{window.TEMPLATES}/users/my_bookmarks/show"])
             .fadeIn()

      # Load the Bookmarks
      $.get("/users/#{window.userObject.id}/bookmarks", (resp) =>
        renderBk(resp)
      )
    )
    @

  renderBookmarks: (resp) ->
    bookmarksEl = $(".bookmarks:first")
    bookmarksEl.html("")

    console.log(bookmarksEl)

    _.each(resp, (bookmark) ->
      #console.log("WTF", bookmark)
      new MyBookmarksBookmarkView({
        el: bookmarksEl,
        model: bookmark
      })
    )
    @

  filterBookmarks: ->
    console.log "KEYPRESSED!!! #{$("input.search").val()}"
