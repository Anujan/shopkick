Shopkick.Routers.Customers = Backbone.Router.extend({
	routes: {
		"customers": "index",
    "customers/new": "create",
		"customers/:id/edit": "edit",
		"customers/:id": "show"
	},

	index: function() {
		this._swapView(new Shopkick.Views.CustomersIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.CustomersEdit( { model: Shopkick.Customers.get(parseInt(id)) }));
	},

	create: function () {
    this._swapView(new Shopkick.Views.CustomersNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.CustomersShow( { model: Shopkick.Customers.get(parseInt(id)) }));
  }
});
