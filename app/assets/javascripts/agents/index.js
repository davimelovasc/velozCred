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

  $(".year_month").each(function() {
    let yd = $(this).html();
    let year = yd.substring(0,5);
    let month = yd.substring(5);
    $(this).html(''+month+'/'+year);
  });


  $("#search").submit(function() {


  });

});
