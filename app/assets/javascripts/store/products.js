jQuery(function() {
  function movePage(resp) {
    if (resp) {
      $("#endless").append(resp);
    }
    $('#pagination-holder').empty();
    $(".pagination").appendTo($('#pagination-holder'));
  }
  movePage();
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url;
      url = $('.pagination .next > a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text('Fetching more products...');
        $.ajax({ url: url, dataType: 'html', success: function(resp) {
          movePage(resp);
        }});
      }
    });
  }
  return $(window).scroll();
});
