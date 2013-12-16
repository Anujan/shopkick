Shopkick.Views.ProductsShow = Backbone.View.extend({

  template: JST['products/show'],
  events: {
    "click #delete": "deleteProduct"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				product: this.model
 			}
 		));
  	return this;
  },

  deleteProduct: function(event) {
  	this.model.destroy();
    Shopkick.ProductsRouter.navigate("products", { trigger: true });
  }
});