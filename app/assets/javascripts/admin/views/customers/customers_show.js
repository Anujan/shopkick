Shopkick.Views.CustomersShow = Backbone.View.extend({

  template: JST['customers/show'],
  events: {
    "click #delete": "deleteCustomer"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				customer: this.model
 			}
 		));
  	return this;
  },

  deleteCustomer: function(event) {
  	this.model.destroy();
    Backbone.History.navigate("customers", { trigger: true });
  }
});