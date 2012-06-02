# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#referer_id").bind 'change', (event) ->
    referer_id = $(@).val()
    $("#referred_by").val("").removeAttr("style")
    $("#loading_referer_name").show()
    $.ajax(
      url: "/admin/users/get_referer_name",
      data: { referer_id: referer_id},
    ).done ( response )->
      if(response==null)
        $("#referred_by").val("Referer does not exist").attr("style","color:#E18B7C");
      else
        $("#referred_by").val(response.name)
      $("#loading_referer_name").hide()
