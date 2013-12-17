Shopkick.Views.CategoriesEdit = Backbone.View.extend({
  template: JST['categories/edit'],

  render: function() {
 		this.$el.html(this.template());
    this.$('#category_form').html(new Shopkick.Views.CategoriesForm({
      model: this.model
    }).render().$el);
  	return this;
  }
});