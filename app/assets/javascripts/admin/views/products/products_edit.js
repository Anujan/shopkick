Shopkick.Views.ProductsEdit = Backbone.View.extend({
  template: JST['products/edit'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#product_form').html(new Shopkick.Views.ProductsForm({ model: this.model }).render().$el);
  	return this;
  }
});