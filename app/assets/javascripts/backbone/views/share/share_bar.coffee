class window.ShareBarView extends Backbone.View
  events: {
    "click a.save" : "saveBookmark"
    "click a.saved" : "unsaveBookmark"
    "click a.report" : "reportBookmark"
  }

  saveBookmark: ->
    if userObject && !@model.attributes.follows
      link = @$el.find("a.save")
      link.html("<i class='icon-save'></i> Saving...")
          .removeClass("save")
          .addClass("saved")

      # User Follows Bookmark
      $.post("/bookmarks/#{@model.attributes.id}/follow",
        (res) =>
          link.html("<i class='icon-save'></i> Saved!")
              .tooltip("fixTitle")
              .tooltip("show")
          @model.attributes.follows = true
          @delegateEvents()
      ).error(->
        alert("An error occurred trying to save the bookmark, please refresh your browser")
      )
    else
      $("#sign-in-dialog").modal()
    false

  unsaveBookmark: ->
    if userObject && @model.attributes.follows && confirm("Are you sure you want to unsave this bookmark? All tracked progress will be gone!")
      link = @$el.find("a.saved")
      link.html("<i class='icon-save'></i> Unfollowing...")
          .removeClass("saved")
          .addClass("save")

      # User Follows Bookmark
      $.post("/bookmarks/#{@model.attributes.id}/unfollow",
        (res) =>
          link.html("<i class='icon-save'></i> Save!")
              .tooltip("fixTitle")
              .tooltip("show")
          @model.attributes.follows = false
          @delegateEvents()
      ).error(->
        alert("An error occurred trying to unsave the bookmark, please refresh your browser")
      )
    else
      $("#sign-in-dialog").modal()
    false

  reportBookmark: ->
    $("#reports-dialog").modal()
    false
