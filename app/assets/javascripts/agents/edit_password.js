$( document ).ready(function() {

  $("#editPasswordForm").submit(function( event ) {
    var password = $("#password").val();
    var password_confirmation = $("#password_confirmation").val();

    if(password === password_confirmation) {
      alert("Senha alterada com sucesso!");
      return;
    } else {
      event.preventDefault();
      alert("A confirmação das senhas falharam.")
    }


  });

  // alert("Para continuar, você precisa definir uma nova senha");

  var options = {
    placement: function (context, source) {
      if ($(window).width() < 974) {
        return "bottom";
      } else {
        return "right";
      }
    }
  };

  $("[data-toggle=popover]").popover(options);
  $(window).resize(function(){
    var width = $(window).width();
    if(width < 974){
      $('#glyph').removeClass('glyphicon-menu-right').addClass('glyphicon-menu-down');
      $('.myInfo').css("margin-top", "10px");
      $('.myInfo').css("margin-left", "30px");
    }
    else if(width > 974){
      $('#glyph').removeClass('glyphicon-menu-down').addClass('glyphicon-menu-right');
      $('.myInfo').css("margin-top", "60px");
      $('.myInfo').css("margin-left", "40px");
    }
  })
  .resize();

  $('#novaSenha').popover();

  $("#new_agent").submit( function() {
    var key_j = $("#inputEmail").val();
    key_j = key_j.toUpperCase();
    $("#inputEmail").val(key_j);
  });

});
