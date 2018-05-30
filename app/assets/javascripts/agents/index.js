$( document ).ready(function() {

  jQuery.propHooks.checked = {
      set: function (el, value) {
          if (el.checked !== value) {
              el.checked = value;
              $(el).trigger('change');
          }
      }
  };

  // Ano/mês
  $("#year_monthsAll").click(function(){
    $('input[name="year_months[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='year_months[]']").click(function(){
      if( $(this).attr("id") != "year_monthsAll" )
      $("#year_monthsAll").prop('checked', false);
  });

  // Segmentos
  $("#segmentsAll").click(function(){
    $('input[name="segments[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='segments[]']").click(function(){
      if( $(this).attr("id") != "segmentsAll" )
      $("#segmentsAll").prop('checked', false);
  });

  // Regionals
  $("#regionalsAll").click(function(){
    $('input[name="regionals[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='regionals[]']").click(function(){
      if( $(this).attr("id") != "regionalsAll" )
      $("#regionalsAll").prop('checked', false);
  });

  // Cargo
  $("#rolesAll").click(function(){
    $('input[name="roles[]"]').not(this).prop('checked', this.checked);
    $('input[name="regionals[]"]').not(this).prop('checked', this.checked);
    $('input[name="agents[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='roles[]']").click(function(){
      if( $(this).attr("id") != "rolesAll" )
      $("#rolesAll").prop('checked', false);
  });


  // Agents
  $("#agentsAll").click(function(){
    $('input[name="agents[]"]').not(this).prop('checked', this.checked);
    $('input[name="regionals[]"]').not(this).prop('checked', this.checked);
    $('input[name="roles[]"]').not(this).prop('checked', this.checked);
  });

  $("input[name='agents[]']").click(function(){
    if( $(this).attr("id") != "agentsAll" )
      $("#agentsAll").prop('checked', false);
  });




  $(".year_month").each(function() {
    let yd = $(this).html();
    let year = yd.substring(0,4);
    let month = yd.substring(4);
    $(this).html(''+month+' / '+year);
  });




  $(".regional").change(function() {
    var a = $(this).val();
    if(a.indexOf(' ') >= 0 ) {
      a = a.split(' ');
      $(".Gerente."+a[0]+"."+a[1]).prop('checked', this.checked);
    } else {
      $(".Gerente."+a).prop('checked', this.checked);
    }

    if(! $(this).prop('checked') )
      $("#agentsAll").prop('checked', false);
  });


  $(".role").change(function() {
    var a = $(this).val();
    $("."+a).prop('checked', this.checked);
    if(! $(this).prop('checked') )
      $("#rolesAll").prop('checked', false);
  });

  $("#Gerente").change(function() {
    if($(this).is(':checked')) {
      $("#regionalsAll").prop('checked', true);
      $(".regional").prop('checked', true);
      $("#regional-div").removeClass("hid");
    } else {
      $("#regionalsAll").prop('checked', false);
      $("#regional-div").addClass("hid");
    }
  });





  $("#search").submit(function() {


  });

});
