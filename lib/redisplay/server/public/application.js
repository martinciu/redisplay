$(function() {
  $('#keys').each(function() {
    var Redisplay = {
      keys_template: Handlebars.compile($("#keys-template").html()),
      value_template: Handlebars.compile($("#value-template").html()),
      getKeys: function(query) {
        $.getJSON('/keys/*' + query + '*', function(keys) {
          $('#keys').html(Redisplay.keys_template({keys: keys}));
          $('#keys li a').click(function(event) {
            event.preventDefault();
            var link = $(this)
            var info = link.parent().find('p');
            if(info.is(':visible')) {
              info.hide();
            } else {
              $.get('/key/' + link.data('key'), function(value) {
                info.html(Redisplay.value_template(value)).show();
              });
            }
          });
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