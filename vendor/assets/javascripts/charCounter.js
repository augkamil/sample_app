  function charCounter() {
    // 140 is the max message length
    var remaining = 140 - jQuery('.message').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining.');
  }

  jQuery(document).ready(function($) {
    charCounter();
    $('.message').change(charCounter);
    $('.message').keyup(charCounter);
  });
