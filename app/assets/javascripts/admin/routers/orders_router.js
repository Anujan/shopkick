Shopkick.Routers.Orders = Backbone.Router.extend({
	routes: {
		"orders": "index",
    "orders/new": "create",
		"orders/:id/edit": "edit",
		"orders/:id": "show"
	},

  fetched: false,

  collection: function() {
    return Shopkick.ordersCollection;
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
    var self = this;
    if (Shopkick.customersCollection.fetched && Shopkick.productsCollection.fetched) {
      this._swapView(new Shopkick.Views.OrdersNew());
    } else {
      if (!Shopkick.customersCollection.fetched) {
        Shopkick.customersCollection.fetch({ success: function() {
          self._swapView(new Shopkick.Views.OrdersNew());
        }});
      }
      if (!Shopkick.productsCollection.fetched) {
        Shopkick.productsCollection.fetch({ success: function() {
          self._swapView(new Shopkick.Views.OrdersNew());
        }});
      }
    }
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.OrdersShow(), {
      modelId: parseInt(id)
    });
  }
});
