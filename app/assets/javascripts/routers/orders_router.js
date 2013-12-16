Shopkick.Routers.Orders = Backbone.Router.extend({
	routes: {
		"orders": "index",
		"orders/:id": "show",
		"orders/:id/edit": "new",
		"orders/new": "new"
	},

	index: function() {

		this._swapView(new Shopkick.Views.OrdersIndex({

		}));
	},

	show: function(id) {

	},

	new: function() {

	},

	edit: function(id) {

	}
});
