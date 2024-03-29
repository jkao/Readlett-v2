$( ->
  NOTIFICATIONS_AREA = $("#notifications")

  window.errorNotification = (errorText) ->
    close = $("<a>").addClass("close")
                    .attr("data-dismiss", "alert")
                    .attr("href", "#")
                    .append("x")
    text = $("<p>").append(errorText)
    errorNotification = $("<div>").append(close)
                                  .append(text)
                                  .addClass("alert")
                                  .addClass("alert-block")
                                  .addClass("alert-error")
                                  .addClass("fade")
                                  .addClass("in")
                                  .hide()
    NOTIFICATIONS_AREA.append(errorNotification)
    errorNotification.fadeIn()

  window.successNotification = (successText) ->
    close = $("<a>").addClass("close")
                    .attr("data-dismiss", "alert")
                    .attr("href", "#")
                    .append("x")
    text = $("<p>").append(successText)
    successNotification = $("<div>").append(close)
                                  .append(text)
                                  .addClass("alert")
                                  .addClass("alert-block")
                                  .addClass("alert-success")
                                  .addClass("fade")
                                  .addClass("in")
                                  .hide()
    NOTIFICATIONS_AREA.append(successNotification)
    successNotification.fadeIn()
)
