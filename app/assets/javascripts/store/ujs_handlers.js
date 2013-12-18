$(document).ready(function() {
  $(document).on("ajax:complete", 'a[data-type=html]', function(event, data, status) {
    $("#main-content").html(data.responseText);
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
      var itemPrice = tr.find(".price").text().trim().slice(1);
      tr.remove();
      var price = $(".summary .price .total").text().trim().slice(1);
      var newPrice = price - itemPrice;
      console.log(itemPrice, price, newPrice);
      $(".summary .price .total").text("$" + newPrice);
    }
  });
});

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}