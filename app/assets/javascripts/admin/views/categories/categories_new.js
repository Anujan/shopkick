Shopkick.Views.CategoriesNew = Backbone.View.extend({

  initialize: function() {
    this.model = new Shopkick.Models.Category();
  },

  template: JST['categories/new'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#category_form').html(new Shopkick.Views.CategoriesForm({
      model: this.model
    }).render().$el);
  	return this;
  }
});