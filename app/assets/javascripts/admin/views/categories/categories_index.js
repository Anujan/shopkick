Shopkick.Views.CategoriesIndex = Backbone.View.extend({

	initialize: function() {
		this.listenTo(Shopkick.Categories, "remove", this.render);
		this.listenTo(Shopkick.Categories, "add", this.render);
		this.listenTo(Shopkick.Categories, "change", this.render);
	},

  template: JST['categories/index'],

  events: {
  	"click #delete" : "deleteCategory"
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				categories: Shopkick.Categories
 			}
 		));
  	return this;
  },

  deleteCategory: function(event) {
  	$a = $(event.currentTarget);
  	var categoryId = $a.data("id");
  	var category = Shopkick.Categories.get(categoryId);
  	category.destroy();
  }
});