Shopkick.Routers.Orders = Backbone.Router.extend({
	routes: {
		"orders": "index",
    "orders/new": "create",
		"orders/:id/edit": "edit",
		"orders/:id": "show"
	},

  fetched: false,

  collection: function() {
    return Shopkick.Orders;
  },

	index: function() {
		this._swapView(new Shopkick.Views.OrdersIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.OrdersEdit(), {
      modelId: parseInt(id)
    });
	},

	create: function () {
    this._swapView(new Shopkick.Views.OrdersNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.OrdersShow(), {
      modelId: parseInt(id)
    });
  }
});
