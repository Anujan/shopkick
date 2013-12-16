Shopkick.Views.ProductsForm = Backbone.View.extend({
  validation_errors: [],

  events: {
    "submit" : 'submitForm',
    "change #image_upload" : "handleFiles"
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
    json["product"]["images_attributes"] = [{ "photo": $(event.currentTarget).find("#image_upload").data("file") }]
    var model = this.model;
    var self = this;
    this.$el.html("<h2>Please wait while we add the product...</h2>")
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
  },

  handleFiles: function (event) {
    var files = $(event.currentTarget)[0].files;
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function(e) {
      $("#image_upload").data("file", this.result);
    }
    reader.readAsDataURL(file);
  }
});