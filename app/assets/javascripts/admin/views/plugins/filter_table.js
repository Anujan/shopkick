Shopkick.Views.FilterTable = Backbone.View.extend({
  initialize: function(options) {
    this.filterView = options.filteredView;
    this.listenTo(this.filterView, "filter", this.render);
    this.template = options.template;
    this.key = options.key || "models";
  },

  tagName: 'table',

  attributes: {
    "cellspacing": 10,
    "cellpadding": 10
  },

  render: function() {
    var params = {};
    params[this.key] = this.filterView.filteredCollection();
 		this.$el.html(this.template(params));
  	return this;
  }
});