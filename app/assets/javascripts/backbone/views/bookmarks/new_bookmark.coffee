class window.NewBookmarkView extends Backbone.View

  events:
    "click button.create-new-bookmark"  : "submitForm"
    "change input.url"                  : "runUrlValidations"

  initialize: ->
    @render()

  render: ->
    _this = this

    @$el.fadeOut( ->
      $(this).html(JST["#{window.TEMPLATES}/bookmarks/new_bookmark"](@viewData))
             .fadeIn()
      $("input.tags").tagit({
        caseSensitive: false
      })

      # If Redirected from Bookmarklet, Prepopulate the URL
      if window.bookmarkletUrl.length > 0
        _this.$("input.url").val(window.bookmarkletUrl)
                            .trigger("change")
    )
    @

  viewData:
    url : @url

  runUrlValidations: ->
    el = $("input.url")

    # Clean Up
    @resetUIState()
    @trimUrl(el)
    @prependHttpIfNotPresent(el)

    # Validation
    @validateUrl(el)

  # Resets the Form UI State
  resetUIState: (el) ->
    $(".control-group.url").removeClass("error")
    $(".control-group.url .error-messages").text("")

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
    if !el.val().match(/^(https?):[/][/]([0-9a-z-])+([\.][0-9a-z]+)+([/][a-z0-9]*)*([?].*)?$/i)
      $(".control-group.url").addClass("error")
      $(".control-group.url .error-messages").text("Looks like a badly formatted URL, buddy! (http://www.example.com)")
      false
    else
      true

  # Wraps around all Tag Validators
  runTagValidations: ->
    el = $("input.tags")

    # Clean Up
    @resetTagFormState()

    # Validations
    @atLeastNumberOfTags(1, el)

  resetTagFormState: ->
    $(".control-group.tags").removeClass("error")
    $(".control-group.tags .error-messages").text("")

  atLeastNumberOfTags: (num, el) ->
    if (el.tagit("assignedTags").length < num)
      $(".control-group.tags").addClass("error")
      $(".control-group.tags .error-messages").text("Add a Tag or two, please! :)")
      false
    else
      true

  submitForm: ->
    return false if $("button.create-new-bookmark").hasClass("disabled")
    $(".control-group.general-errors span.error-messages").html("")

    if @runUrlValidations() & @runTagValidations()
      console.log("SUBMIT!")
      $("button.create-new-bookmark").addClass("disabled")
                                     .text("Creating...")
      submissionDetails = {
        url: $("input.url").val(),
        tags: $("input.tags").tagit("assignedTags")
      }
      $.post("/bookmarks/", submissionDetails, (resp) ->
        if resp.errors # Error
          $(".control-group.general-errors span.error-messages").html("<i class='icon-warning-sign'></i> ERROR: #{resp.errors}")
        else # Success
          window.successNotification("Bookmark Successfully Created!")
          window.router.navigate("", trigger: true)
      ).error( ->
        alert("There was an error. Please refresh the page :(")
      )
    else
      console.log("NO SUBMIT!")

    false
