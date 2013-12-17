Shopkick.Views.CategoriesShow = Backbone.View.extend({
  template: JST['categories/show'],
  events: {
    "click #delete": "deleteCategory"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				category: this.model
 			}
 		));
  	return this;
  },

  deleteCustomer: function(event) {
  	this.model.destroy();
    Shopkick.CustomersRouter.navigate("categories", { trigger: true });
  }
});