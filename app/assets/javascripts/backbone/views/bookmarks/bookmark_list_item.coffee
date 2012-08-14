class window.BookmarkListItemView extends Backbone.View

  BOOKMARK_LIST_ITEM = "bookmarks/bookmark_list_item"

  events: {
    "click .bookmark li.save a.save" : 'saveBookmark'
    "click .bookmark li.save a.saved" : 'unsaveBookmark'
  }

  initialize: (options) ->
    @render()

  render: ->
    @$el.html(JST["#{TEMPLATES}/#{BOOKMARK_LIST_ITEM}"](@viewData()))

  saveBookmark: (el) =>
    if userObject && !@model.attributes.follows
      link = @$el.find("li.save a.save")
      link.attr("title", "Saving...")
          .tooltip("fixTitle")
          .tooltip("show")
          .removeClass("save")
          .addClass("saved")

      # User Follows Bookmark
      $.post("/bookmarks/#{@model.attributes.id}/follow",
        (res) =>
          link.attr("title", "Saved!")
              .tooltip("fixTitle")
              .tooltip("show")
          @delegateEvents()
          console.log("DELEGATE FOLLOW")
          false
      )
    else
      $("#sign-in-dialog").modal()
    false

  unsaveBookmark: (el) =>
    if userObject && @model.attributes.follows
      link = @$el.find("li.save a.saved")
      console.log(link)
      link.attr("title", "Unfollowing...")
          .tooltip("fixTitle")
          .tooltip("show")
          .removeClass("saved")
          .addClass("save")

      # User Follows Bookmark
      $.post("/bookmarks/#{@model.attributes.id}/unfollow",
        (res) =>
          link.attr("title", "Save!")
              .tooltip("fixTitle")
              .tooltip("show")
          @delegateEvents()
          console.log("DELEGATE UNFOLLOW")
          # TODO: Handle Error Case
          false
      )
    else
      $("#sign-in-dialog").modal()
    false

  viewData: ->
    bookmark: @model
