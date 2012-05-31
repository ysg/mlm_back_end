$(document).ready(function() {
      $(".network-modal-link").bind("ajax:success",
               function(evt, data, status, xhr){
                    //this assumes the action returns an HTML snippet
                    $("#network-modal").html(data);
       });
});
