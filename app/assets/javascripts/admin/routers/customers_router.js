Shopkick.Routers.Customers = Backbone.Router.extend({
	routes: {
		"customers": "index",
    "customers/new": "create",
		"customers/:id/edit": "edit",
		"customers/:id": "show"
	},

  fetched: false,

  collection: function() {
    return Shopkick.Customers;
  },

	index: function() {
		this._swapView(new Shopkick.Views.CustomersIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.CustomersEdit(), {
      modelId: parseInt(id)
    });
	},

	create: function () {
    this._swapView(new Shopkick.Views.CustomersNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.CustomersShow(), {
      modelId: parseInt(id)
    });
  }
});