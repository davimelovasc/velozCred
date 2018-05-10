$("#new_agent").submit( function() {
  let key_j = $("inputEmail").val();
  key_j.toUpperCase();
  $("inputEmail").val(key_j);
});
