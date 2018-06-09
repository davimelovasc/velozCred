function round(value, precision) {
    var multiplier = Math.pow(10, precision || 0);
    return Math.round(value * multiplier) / multiplier;
}

$( document ).ready(function() {

  $(".percent").each(function() {
    var v = round($(this).html(), 2);
    $(this).html(v + '%');
  });

  $(".real").each(function() {
    var valor = parseFloat( $(this).html() );
    var texto = valor.toLocaleString("pt-BR", { style: "currency" , currency:"BRL"});

    $(this).html(texto.substring(3));
  });

});
