Shopkick.Routers.Orders = Backbone.Router.extend({
	routes: {
		"orders": "index",
    "orders/new": "create",
		"orders/:id": "show",
		"orders/:id/edit": "edit"
	},

	index: function() {
		this._swapView(new Shopkick.Views.OrdersIndex());
	},

	edit: function(id) {

	},

	create: function() {
    this._swapView(new Shopkick.Views.OrdersNew());
	},

	edit: function(id) {

	}
});
