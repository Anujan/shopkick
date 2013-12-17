Shopkick.Models.Order = Backbone.Model.extend({
  FULFILLMENT_STATUSES: ['Not fulfilled', 'In Process', 'Fulfilled'],
  PAYMENT_STATUSES: ['Unpaid', 'Pending', 'Paid'],
  urlRoot: 'admin/orders',
  customer_name: function() {
    if (this.get("customer")) {
      return this.get("customer").full_name();
    } else {
      return "";
    }
  },
	parse: function(resp) {
		if (resp.customer) {
			resp.customer = new Shopkick.Models.Customer(resp.customer, { parse: true });
		}
    if (resp.products) {
      resp.products = new Shopkick.Collections.Products(resp.products, { parse: true });
    }
		return resp;
	},
	toJSON: function(options) {
    var clone = _.clone(this.attributes);
    if (!options.keepAssociations) {
      delete clone.customer;
      delete clone.products;
    } else {
    	clone.customer = clone.customer.toJSON();
      clone.products = clone.products.toJSON();
    }
    return clone;
  }
});
