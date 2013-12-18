jQuery(function() {
  movePage();
  $(window).scroll(function() {
      if ($('.pagination').length) {
        var url;
        url = $('.pagination .next > a').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.pagination').text('Fetching more products...');
          $.ajax({ url: url, dataType: 'html', data: { infinite: true }, success: function(resp) {
            movePage(resp);
          }});
        }
      }
  });
  return $(window).scroll();
});
function movePage(resp) {
  if ($('.pagination').length) {
    if (resp) {
      $("#endless").append(resp);
    }
    $('#pagination-holder').empty();
    $(".pagination").appendTo($('#pagination-holder'));
  }
}