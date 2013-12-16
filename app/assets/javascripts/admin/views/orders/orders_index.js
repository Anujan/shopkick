Shopkick.Views.OrdersIndex = Backbone.View.extend({

	initialize: function() {
		this.listenTo(Shopkick.Orders, "remove", this.render);
		this.listenTo(Shopkick.Orders, "add", this.render);
		this.listenTo(Shopkick.Orders, "change", this.render);
	},

  template: JST['orders/index'],
  
  events: {
  	"click #delete" : "deleteOrder"
  },
  
  render: function() {
 		this.$el.html(this.template(
 			{
 				orders: Shopkick.Orders
 			}
 		));
  	return this;
  },

  deleteOrder: function(event) {
  	$a = $(event.currentTarget);
  	var orderId = $a.data("id");
  	var order = Shopkick.Orders.get(orderId);
  	order.destroy();
  }
});