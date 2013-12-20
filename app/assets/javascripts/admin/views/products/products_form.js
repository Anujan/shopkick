Shopkick.Views.ProductsForm = Backbone.View.extend({
  initialize: function() {
    this.listenTo(Shopkick.categoriesCollection, "sync", this.render);
  },

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
    if (!Shopkick.categoriesCollection.length) {
      Shopkick.categoriesCollection.fetch();
    }

    this.$el.html(this.template({
      product: this.model,
      errors: this.validation_errors
    }));

    this.$('select').chosen({
      allow_single_deselect: true,
      no_results_text: 'No results matched',
      width: '286px'
    });

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
        Shopkick.productsCollection.add(model, { at: 0 });
        Backbone.history.navigate("/products", { trigger: true });
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