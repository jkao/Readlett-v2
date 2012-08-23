class window.UpdateMyBookmarksView extends Backbone.View
  # TODO: Should just use inheritance to keep it DRY
  # TODO: For URL Checking we should also Mixin the capabilities for validation - DRY

  MIN_SEARCH_LENGTH = 0

  events:
    "keyup input.search"          : "filterBookmarks"
    "change input.url"            : "runUrlValidations"
    "update:bookmark .bookmark.row.hover"    : "updateBookmark"
    #"click .bookmark.row.hover"    : "updateBookmark"

  initialize: ->
    @render()

  render: ->
    renderBk = @renderBookmarks
    @$el.fadeOut( ->
      $(this).html(JST["#{window.TEMPLATES}/users/my_bookmarks/update"](model: @model))
      $(".bookmarks:first").html("<div class='span9 loading'>&nbsp;</div>")

      if window.bookmarkletUrl.length > 0
        $("input.url").val(window.bookmarkletUrl)
                      .trigger("change")

      $(this).fadeIn()

      # Load the Bookmarks
      $.get("/users/#{window.userObject.id}/bookmarks", (resp) =>
        renderBk(resp)
      )
    )
    @

  renderBookmarks: (resp) =>
    bookmarksEl = $(".bookmarks:first")
    bookmarksEl.html("")

    if resp.length > 0
      _.each(resp, (bookmark) =>
        bookmarkEl = new MyBookmarksBookmarkView({
          model: bookmark,
          mode: "update"
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

  runUrlValidations: ->
    el = $("input.url")

    # Clean Up
    @resetUIState()
    @trimUrl(el)
    @prependHttpIfNotPresent(el)

    # Validation
    @validateUrl(el)

  # TODO: Massage these in to the current update form
  # Resets the Form UI State
  resetUIState: () ->
    $("#update-messages").removeClass("red-notification")
                         .addClass("blue-notification")
    $("#update-messages").find(".span9 h4").text("")

  # Snips Out Whitespaces
  trimUrl: (el) ->
    el.val(el.val().replace /^\s+|\s+$/g, "")

  # If it doesn't start with "http://" or "https://"
  # -> Prepend it for them
  prependHttpIfNotPresent: (el) ->
    if !el.val().match(/(http|https)[:][/][/]/i)
      el.val("http://#{el.val()}")

  # Main Client-Side URL Validator
  validateUrl: (el) ->
    if !el.val().match(/^(https?):[/][/]([0-9a-z-])+([\.][0-9a-z]+)+([/][a-z0-9-.]*)*([?].*)?([#].*)$/i)
      $("#update-messages").find(".span9 h4")
                           .html("<i class='icon-remove-sign' style='vertical-align:baseline;'></i> Looks like a badly formatted URL, buddy! (http://www.example.com)")
      $("#update-messages").addClass("red-notification")
                           .removeClass("blue-notification")
      false
    else
      $("#update-messages").find(".span9 h4")
                           .html("<i class='icon-ok-sign' style='vertical-align:baseline;'></i> URL looks Good - Click one of your Bookmarks to Update!")
      $("#update-messages").addClass("blue-notification")
                           .removeClass("red-notification")
      true

  updateBookmark: (e, bookmarkId) ->
    if (@runUrlValidations()) # Good to go if Validations Pass
      data = {
        bookmark_id: bookmarkId,
        new_url: @$("input.url").val()
      }

      # Disable Text Inputs in UI
      @$("input[type='text']").attr("disabled", true)
      @$("#update-messages .span9 h4").show()
                                      .html("Updating Position... <div class='loading'></div>")

      $.post("/users/#{window.userObject.id}/update_bookmark_position", data, (resp) ->
        window.successNotification("Successfully updated your spot to: #{data.new_url}")
        window.router.navigate("", trigger: true)
      ).error( ->
        alert "There was an Error Updating the Bookmark Position. Please Refresh your Browser"
      )
    false
