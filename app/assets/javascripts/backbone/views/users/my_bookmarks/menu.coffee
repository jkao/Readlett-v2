class window.MyBookmarksMenuView extends Backbone.View
  events:
    'click #show'     : 'changeUrlToShow'
    'click #add'      : 'changeUrlToAdd'
    'click #up'       : 'changeUrlToUpdate'

  titleHash:
    "#show" : "My Bookmarks"
    "#add"  : "Track a New Bookmark"
    "#up"   : "Update Your Bookmark Position"

  updateTitle: (titleKey) ->
    $("#my-bookmarks-title").text(@titleHash[titleKey])

  resetListColors: ->
    $("#menu ul li").each( ->
      $(this).removeClass("selected")
    )

  # UI Component
  initialize: (options) ->
    # Render HTML Template
    @render()

    # Colors
    @resetListColors()
    $(options.selectedEl).addClass("selected")

    # Title
    @updateTitle(options.selectedEl)

    false

  render: ->
    # Render the Template
    @$el.html(JST["#{window.TEMPLATES}/users/my_bookmarks/menu"])

  changeUrlToAdd: ->
    window.router.navigate("create", trigger:true)

  changeUrlToShow: ->
    window.router.navigate("", trigger:true)

  changeUrlToUpdate: ->
    window.router.navigate("update", trigger:true)
