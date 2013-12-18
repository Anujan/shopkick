$(document).ready(function() {
  $(document).on("ajax:complete", 'a[data-type=html]', function(event, data, status) {
    $("#main-content").html(data.responseText);
    updateURL(event.target.href);
    movePage();
    var $div = $("#alerts");
    $div.empty();
  });
  $(document).on("ajax:complete", 'a[data-type=json]', function(event, data, status) {
    var $div = $("#alerts");
    $div.empty();
    var alertType = data.responseJSON[0][0];
    var alertText = data.responseJSON[0][1];
    var html = '<div class="alert ' + alertType + '"><strong class="' + alertType + '">' + alertType.capitalize() + '! </strong>';
    html += alertText;
    html += '</div>';
    $div.html(html);
    $a = $(this)[0];
    if ($a.className == 'remove-cart-item') {
      var tr = $(this).closest("tr");
      var itemPrice = NumberHelpers.currency_to_number(tr.find(".price").text());
      tr.remove();
      var price = NumberHelpers.currency_to_number($(".summary .price .total").text());
      var newPrice = price - itemPrice;
      if (newPrice > 0) {
        $(".summary .price .total strong").text(NumberHelpers.number_to_currency(newPrice));
      } else {
        $("table").remove();
        $("#cart").html("<h1>Your cart is empty...</h1>");
      }
    }
  });
});

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

function updateURL(url) {
  if (history && history.pushState) {
    history.pushState(null, document.title, url);
  }
}