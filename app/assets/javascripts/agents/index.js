$( document ).ready(function() {

  $("#regionalsAll").click(function(){
    $('input[name="regionals"]').not(this).prop('checked', this.checked);
  });

  $("#agentsAll").click(function(){
    $('input[name="agents"]').not(this).prop('checked', this.checked);
  });



});
