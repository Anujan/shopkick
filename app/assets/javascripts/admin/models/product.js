Shopkick.Models.Product = Backbone.Model.extend({
  urlRoot: 'admin/products',
	parse: function(resp) {
		if (resp.images) {
			resp.images = new Shopkick.Collections.Images(resp.images);
      resp.category = new Shopkick.Models.Category(resp.category);
		}
		return resp;
	},
	toJSON: function(options) {
    var clone = _.clone(this.attributes);
    if (!options.keepAssociations) {
      delete clone.images;
      delete clone.category;
    } else {
    	clone.images = clone.images.toJSON();
      clone.category = clone.category.toJSON();
    }
    return clone;
  }
});
