Shopkick.Views.SideNavigation = Backbone.View.extend({
	template: HandlebarsTemplates['side_nav'],
	render: function() {
		this.$el.html(this.template());
		return this;
	}
});