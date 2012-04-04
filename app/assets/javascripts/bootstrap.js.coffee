jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  # Disable buttons that are disabled
  $(".btn.disabled").on "click", (e) ->
    e.preventDefault()
