Shopkick.Routers.Orders = Backbone.Router.extend({
	routes: {
		"orders": "index",
    "orders/new": "create",
		"orders/:id/edit": "edit",
		"orders/:id": "show"
	},

	index: function() {
		this._swapView(new Shopkick.Views.OrdersIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.OrdersEdit( { model: Shopkick.Orders.get(parseInt(id)) }));
	},

	create: function () {
    this._swapView(new Shopkick.Views.OrdersNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.OrdersShow( { model: Shopkick.Orders.get(parseInt(id)) }));
  }
});
