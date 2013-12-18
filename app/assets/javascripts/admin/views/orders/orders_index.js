Shopkick.Views.OrdersIndex = Backbone.View.extend({

	initialize: function() {
    this.filterView = new Shopkick.Views.FilterInput({
      collection: Shopkick.ordersCollection,
      searchAttributes: ["id", "customer_name", "payment_status", "fulfillment_status"]
    });

    this.tableView = new Shopkick.Views.FilterTable({
      filteredView: this.filterView,
      template: JST['orders/table'],
      key: "orders"
    });
	},

  template: JST['orders/index'],

  events: {
  	"click #delete" : "deleteOrder"
  },

  render: function() {
 		this.$el.html(this.template());
    this.$("#filter-field").append(this.filterView.$el);
    this.$("#orders-table").append(this.tableView.render().$el);
  	return this;
  },

  deleteOrder: function(event) {
  	$a = $(event.currentTarget);
  	var orderId = $a.data("id");
  	var order = Shopkick.ordersCollection.get(orderId);
  	order.destroy();
  }
});