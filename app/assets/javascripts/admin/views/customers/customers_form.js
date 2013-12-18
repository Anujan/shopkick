Shopkick.Views.CustomersForm = Backbone.View.extend({
  validation_errors: [],

  events: {
    "submit" : 'submitForm'
  },

  template: JST['customers/form'],

  tagName: 'form',

  render: function() {
    this.$el.html(this.template({
      customer: this.model,
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
        Shopkick.customersCollection.add(model, { at: 0 });
        Backbone.history.navigate("/customers", { trigger: true });
      },
      error: function(model, xhr, options) {
        self.validation_errors = xhr.responseJSON;
        self.render();
      }
    });
  }
});