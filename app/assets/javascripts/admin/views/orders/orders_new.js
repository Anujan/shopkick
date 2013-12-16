Shopkick.Views.OrdersNew = Backbone.View.extend({

  initialize: function() {
    this.model = new Shopkick.Models.Order();
  },

  template: JST['orders/new'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#order_form').html(new Shopkick.Views.OrdersForm({ model: this.model }).render().$el);
  	return this;
  }
});