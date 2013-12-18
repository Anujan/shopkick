Shopkick.Views.ProductsIndex = Backbone.View.extend({

	initialize: function() {
    this.filterView = new Shopkick.Views.FilterInput({
      collection: Shopkick.Products
    });

    this.tableView = new Shopkick.Views.FilterTable({
      filteredView: this.filterView,
      template: JST['products/table'],
      key: "products"
    });
	},

  template: JST['products/index'],

  events: {
  	"click #delete" : "deleteProduct"
  },

  render: function() {
 		this.$el.html(this.template({
 		  products: this.filterView.filteredCollection()
 		}));
    this.$("#filter-field").append(this.filterView.$el);
    this.$("#products-table").append(this.tableView.render().$el);
  	return this;
  },

  deleteProduct: function(event) {
  	$a = $(event.currentTarget);
  	var productId = $a.data("id");
  	var product = Shopkick.Products.get(productId);
    product.destroy();
  }
});