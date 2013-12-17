Shopkick.Views.CustomersIndex = Backbone.View.extend({

	initialize: function() {
    this.filterView = new Shopkick.Views.FilterInput({
      collection: Shopkick.Customers,
      searchAttributes: ["full_name"]
    });

    this.tableView = new Shopkick.Views.FilterTable({
      filteredView: this.filterView,
      template: JST['customers/table'],
      key: "customers"
    });
	},

  template: JST['customers/index'],

  events: {
  	"click #delete" : "deleteCustomer"
  },

  render: function() {
 		this.$el.html(this.template());
    this.$("#filter-field").append(this.filterView.$el);
    this.$("#customers-table").append(this.tableView.render().$el);
  	return this;
  },

  deleteCustomer: function(event) {
  	$a = $(event.currentTarget);
  	var customerId = $a.data("id");
  	var customer = Shopkick.Customers.get(customerId);
  	customer.destroy();
  }
});