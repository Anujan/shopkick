Shopkick.Models.Product = Backbone.Model.extend({
	parse: function(resp) {
		if (resp.images) {
			resp.images = new Shopkick.Collections.Images(resp.images);
		}
		return resp;
	},
	toJSON: function(options) {
    var clone = _.clone(this.attributes);
    if (!options.keepAssociations) {
      delete clone.images;
    } else {
    	clone.images = clone.images.toJSON();
    }
    return clone;
  }
});
