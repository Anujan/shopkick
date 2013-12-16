Shopkick.Views.CustomersNew = Backbone.View.extend({

  initialize: function() {
    this.model = new Shopkick.Models.Customer();
  },

  template: JST['customers/new'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#customer_form').html(new Shopkick.Views.CustomersForm({ model: this.model }).render().$el);
  	return this;
  }
});