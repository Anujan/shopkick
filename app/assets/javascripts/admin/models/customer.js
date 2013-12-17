Shopkick.Models.Customer = Backbone.Model.extend({
  urlRoot: 'admin/customers',
  full_name: function() {
  	return this.escape("first_name") + " " + this.escape("last_name");
  },
  full_address: function() {
    var attrs = ['address_street', 'address_city', 'address_state', 'address_country'];
    var self = this;
    return attrs.map(function(attr) {
      return self.get(attr);
    }).join(", ");
  }
});
