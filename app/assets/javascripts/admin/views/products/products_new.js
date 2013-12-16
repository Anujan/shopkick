Shopkick.Views.ProductsNew = Backbone.View.extend({

  initialize: function() {
    this.model = new Shopkick.Models.Product();
  },

  template: JST['products/new'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#product_form').html(new Shopkick.Views.ProductsForm({ model: this.model }).render().$el);
  	return this;
  }
});