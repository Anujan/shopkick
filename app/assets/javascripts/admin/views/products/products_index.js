Shopkick.Views.ProductsIndex = Backbone.View.extend({

	initialize: function() {
		this.listenTo(Shopkick.Products, "remove", this.render);
		this.listenTo(Shopkick.Products, "add", this.render);
		this.listenTo(Shopkick.Products, "change", this.render);
	},

  template: JST['products/index'],

  events: {
  	"click #delete" : "deleteProduct"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				products: Shopkick.Products
 			}
 		));
  	return this;
  },

  deleteProduct: function(event) {
  	$a = $(event.currentTarget);
  	var productId = $a.data("id");
  	var product = Shopkick.Products.get(productId);
  	product.destroy();
  }
});