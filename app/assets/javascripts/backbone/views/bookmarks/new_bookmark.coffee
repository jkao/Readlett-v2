class window.NewBookmarkView extends Backbone.View

  events:
    "click button.create-new-bookmark"  : "submitForm"
    "change input.url"                  : "runUrlValidations"

  initialize: ->
    @render()

  render: ->
    @$el.fadeOut( ->
      $(this).html(JST["#{window.TEMPLATES}/bookmarks/new_bookmark"](@viewData))
             .fadeIn()
    )
    @

  viewData:
    url : @url

  runUrlValidations: ->
    el = $("input.url")
    @resetUIState()
    @trimUrl(el)
    @prependHttpIfNotPresent(el)
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
    if !el.val().match(/^(https?):[/][/]([0-9a-z])+([\.][0-9a-z]+)+([/][a-z0-9]*)*([?].*)?$/i)
      $(".control-group.url").addClass("error")
      $(".control-group.url .error-messages").text("Looks like a badly formatted URL, buddy! (http://www.example.com)")
    false

  # Wraps around all Tag Validators
  runTagValidations: ->
    # TODO
    false

  submitForm: ->
    @runUrlValidations()
    @runTagValidations()
    false
