Shopkick.Models.Customer = Backbone.Model.extend({
  full_name: function() {
  	return this.escape("first_name") + " " + this.escape("last_name");
  }
});
