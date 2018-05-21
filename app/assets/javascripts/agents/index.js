$( document ).ready(function() {

  // Regionals
  $("#regionalsAll").click(function(){
    $('input[name="regionals[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='regionals[]']").click(function(){
      if( $(this).attr("id") != "regionalsAll" )
      $("#regionalsAll").prop('checked', false);
  });

  // Agents
  $("#agentsAll").click(function(){
    $('input[name="agents[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='agents[]']").click(function(){
    if( $(this).attr("id") != "agentsAll" )
      $("#agentsAll").prop('checked', false);
  });



  $("#search").submit(function() {
  

  });

});
