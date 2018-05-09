$("#new_agent").submit( function() {
  let key_j = $("inputEmail").val();
  key_j.toUpperCase();
  alert("key j: "+ key_j);
  $("inputEmail").val(key_j);
});
