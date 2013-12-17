Shopkick.Routers.Categories = Backbone.Router.extend({
	routes: {
		"categories": "index",
    "categories/new": "create",
		"categories/:id/edit": "edit",
		"categories/:id": "show"
	},

  fetched: false,

  collection: function() {
      return Shopkick.Categories;
  },

	index: function() {
		this._swapView(new Shopkick.Views.CategoriesIndex());
	},

	edit: function (id) {
    this._swapView(new Shopkick.Views.CategoriesEdit(), {
      modelId: parseInt(id)
    });
	},

	create: function () {
    this._swapView(new Shopkick.Views.CategoriesNew());
	},

  show: function (id) {
    this._swapView(new Shopkick.Views.CategoriesShow(), {
      modelId: parseInt(id)
    });
  }
});