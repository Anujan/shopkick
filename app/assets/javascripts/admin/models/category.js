Shopkick.Models.Category = Backbone.Model.extend({
	parse: function(resp) {
		if (resp.products) {
			resp.products = new Shopkick.Collections.Products(resp.products);
		}
		return resp;
	},
	toJSON: function(options) {
    var clone = _.clone(this.attributes);
    if (!options.keepAssociations) {
      delete clone.products;
    } else {
    	clone.products = clone.products.toJSON();
    }
    return clone;
  }
});
