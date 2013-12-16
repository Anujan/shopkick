Shopkick.Routers.Products = Backbone.Router.extend({
	routes: {
		"products": "index",
    "products/new": "create",
		"products/:id/edit": "edit",
		"products/:id": "show"
	},

	index: function() {
		this._swapView(new Shopkick.Views.ProductsIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.ProductsEdit( { model: Shopkick.Products.get(parseInt(id)) }));
	},

	create: function () {
    this._swapView(new Shopkick.Views.ProductsNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.ProductsShow( { model: Shopkick.Products.get(parseInt(id)) }));
  }
});
