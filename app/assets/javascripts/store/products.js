jQuery(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url;
      url = $('.pagination .next > a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text('Fetching more products...');
        $.ajax({ url: url, dataType: 'html', success: function(resp) {
          $('.pagination').remove();
          $("#endless").append(resp);
          $('.pagination').appendTo('#pagination-holder');
        }});
      }
    });
  }
  return $(window).scroll();
});
