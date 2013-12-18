Shopkick.Views.CategoriesIndex = Backbone.View.extend({

	initialize: function() {
    this.filterView = new Shopkick.Views.FilterInput({
      collection: Shopkick.categoriesCollection
    });

    this.tableView = new Shopkick.Views.FilterTable({
      filteredView: this.filterView,
      template: JST['categories/table'],
      key: "categories"
    });
	},

  template: JST['categories/index'],

  events: {
  	"click #delete" : "deleteCategory"
  },

  render: function() {
 		this.$el.html(this.template());
    this.$("#filter-field").append(this.filterView.$el);
    this.$("#categories-table").append(this.tableView.render().$el);
  	return this;
  },

  deleteCategory: function(event) {
  	$a = $(event.currentTarget);
  	var categoryId = $a.data("id");
  	var category = Shopkick.categoriesCollection.get(categoryId);
  	category.destroy();
  }
});