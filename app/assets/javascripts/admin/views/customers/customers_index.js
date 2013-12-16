Shopkick.Views.CustomersIndex = Backbone.View.extend({

	initialize: function() {
		this.listenTo(Shopkick.Customers, "remove", this.render);
		this.listenTo(Shopkick.Customers, "add", this.render);
		this.listenTo(Shopkick.Customers, "change", this.render);
	},

  template: JST['customers/index'],

  events: {
  	"click #delete" : "deleteCustomer"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				customers: Shopkick.Customers
 			}
 		));
  	return this;
  },

  deleteCustomer: function(event) {
  	$a = $(event.currentTarget);
  	var customerId = $a.data("id");
  	var customer = Shopkick.Customers.get(customerId);
  	customer.destroy();
  }
});