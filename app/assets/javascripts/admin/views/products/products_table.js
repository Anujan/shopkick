Shopkick.Views.ProductsTable = Backbone.View.extend({
  initialize: function(options) {
    this.filterView = options.filteredView;
    this.listenTo(this.filterView, "filter", this.render);
  },

  template: JST['products/table'],

  tagName: 'table',

  attributes: {
    "cellspacing": 10,
    "cellpadding": 10
  },

  render: function() {
 		this.$el.html(this.template(
 			{
 				products: this.filterView.filteredCollection()
 			}
 		));
  	return this;
  }
});