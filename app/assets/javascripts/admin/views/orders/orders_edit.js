Shopkick.Views.OrdersEdit = Backbone.View.extend({
  template: JST['orders/edit'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#order_form').html(new Shopkick.Views.OrdersForm({ model: this.model }).render().$el);
  	return this;
  }
});