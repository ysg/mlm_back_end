$(document).ready ->
  $(".network-modal-link").bind "ajax:complete", (event, data, status, xhr) ->
    $("#network-modal").replaceWith data.responseText
    $("#network-modal").modal "show"
