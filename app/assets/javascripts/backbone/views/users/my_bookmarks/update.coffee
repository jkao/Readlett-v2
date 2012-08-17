class window.UpdateMyBookmarksView extends Backbone.View

  events:
    "" : ""

  initialize: ->
    @render()

  render: ->
    @$el.fadeOut( ->
      $(this).html(JST["#{window.TEMPLATES}/users/my_bookmarks/update"](@viewData))
             .fadeIn()
    )
    @

  viewData:
    "" : ""
