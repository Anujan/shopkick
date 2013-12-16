Shopkick.Views.OrdersNew = Backbone.View.extend({

  initialize: function() {
    this.model = new Shopkick.Models.Order();
  },

  template: JST['orders/new'],
  
  render: function() {
 		this.$el.html(this.template());
  	return this;
  }
});