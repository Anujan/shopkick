Shopkick.Models.Customer = Backbone.Model.extend({
  urlRoot: 'admin/customers',
  full_name: function() {
  	return this.escape("first_name") + " " + this.escape("last_name");
  }
});
