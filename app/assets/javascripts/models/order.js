Shopkick.Models.Order = Backbone.Model.extend({
	parse: function(resp) {
		if (resp.customer) {
			resp.customer = new Shopkick.Models.Customer(resp.customer);
		}
		return resp;
	},
	toJSON: function(options) {
    var clone = _.clone(this.attributes);
    if (!options.keepAssociations) {
      delete clone.customer;
    } else {
    	clone.customer = clone.customer.toJSON();
    }
    return clone;
  }
});
