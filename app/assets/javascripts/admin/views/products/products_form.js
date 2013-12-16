Shopkick.Views.ProductsForm = Backbone.View.extend({
  validation_errors: [],

  events: {
    "submit" : 'submitForm'
  },

  template: JST['products/form'],

  tagName: 'form',
  attributes: {
    "enctype": "multipart/form-data"
  },

  render: function() {
    this.$el.html(this.template({
      product: this.model,
      errors: this.validation_errors
    }));
    return this;
  },

  submitForm: function(event) {
    event.preventDefault();
    var json = $(event.currentTarget).serializeJSON();
    var model = this.model;
    var self = this;
    model.save(json, {
      success: function() {
        Shopkick.Products.add(model, { at: 0 });
        Shopkick.ProductsRouter.navigate("/products", { trigger: true });
      },
      error: function(model, xhr, options) {
        self.validation_errors = xhr.responseJSON;
        self.render();
      }
    });
  }
});