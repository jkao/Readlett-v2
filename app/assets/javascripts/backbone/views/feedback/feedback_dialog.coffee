class window.FeedbackDialogView extends Backbone.View
  events: {
    "click button.feedback" : "sendFeedback"
  }

  sendFeedback: ->
    return false if $("button.feedback").hasClass("disabled")

    # Disable Submit Button
    $("button.feedback").addClass("disabled")
                        .text("Thanks! Sending Feedback...")

    # Set up Post Action
    values = {
      message: $("textarea.message").val()
    }
    $.post("/feedback", values, (resp) =>
      @$el.modal("hide")
    ).error( ->
      alert("An Error has Occurred with Feedback. Please Refresh your Browser")
    )
    false
