Shopkick.Views.CustomersEdit = Backbone.View.extend({
  template: JST['customers/edit'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#customer_form').html(new Shopkick.Views.CustomersForm({ model: this.model }).render().$el);
  	return this;
  }
});