Shopkick.Views.OrdersShow = Backbone.View.extend({

  template: JST['orders/show'],
  events: {
    "click #delete": "deleteOrder"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				order: this.model
 			}
 		));
  	return this;
  },

  deleteOrder: function(event) {
  	this.model.destroy();
    Shopkick.OrdersRouter.navigate("orders", { trigger: true });
  }
});