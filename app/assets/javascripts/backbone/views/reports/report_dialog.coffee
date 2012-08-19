class window.ReportDialogView extends Backbone.View
  events: {
    "click .report-submit" : "sendReport"
  }

  sendReport: ->
    return false if $(".report-submit").hasClass("disabled")

    # Disable the Submit Button
    $(".report-submit").addClass("disabled")
                       .val("Sending Report...")

    # Set up Post Action
    values = {
      "complainer_id" : $("#complainer_id").val(),
      "reason" : $("#reason").val()
    }
    postUrl = $("#report-form form").attr("action")

    # Post It!
    $.post(postUrl, values, (response) ->
      $(".report-submit").val("Report Sent! Thanks!")
      $("#reports-dialog").modal("hide")
    ).error( ->
      alert("An Error has Occurred with Reporting. Please Refresh your Browser")
    )
    false
