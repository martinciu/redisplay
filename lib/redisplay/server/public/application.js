$(function() {
  $('#keys').each(function() {
    var Redisplay = {
      template: Handlebars.compile($("#keys-template").html()),
      getKeys: function(query) {
        $.getJSON('/keys/*' + query + '*', function(keys) {
          $('#keys').html(Redisplay.template({keys: keys}));
        });
      },
      init: function() {
        $('#query').keyup(function() {
          Redisplay.getKeys($(this).val());
        });
        Redisplay.getKeys("");
      }
    }
    Redisplay.init();
  });
});