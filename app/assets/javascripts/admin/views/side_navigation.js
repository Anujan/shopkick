Shopkick.Views.SideNavigation = Backbone.View.extend({
	template: JST['side_nav'],
	render: function() {
		this.$el.html(this.template());
		return this;
	}
});