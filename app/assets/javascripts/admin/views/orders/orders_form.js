Shopkick.Views.OrdersForm = Backbone.View.extend({
  initialize: function() {
    this.listenTo(Shopkick.productsCollection, "sync", this.render);
    this.listenTo(Shopkick.customersCollection, "sync", this.render);
  },

  validation_errors: [],

  events: {
    "submit" : 'submitForm'
  },

  template: JST['orders/form'],

  tagName: 'form',

  render: function() {
    if (!Shopkick.customersCollection.length) {
      Shopkick.customersCollection.fetch();
    }

    if (!Shopkick.productsCollection.length) {
      Shopkick.productsCollection.fetch();
    }

    this.$el.html(this.template({
      order: this.model,
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
    var model = this.model;
    var self = this;
    model.save(json, {
      success: function() {
        Shopkick.ordersCollection.add(model, { at: 0 });
        Backbone.history.navigate("/orders", { trigger: true });
      },
      error: function(model, xhr, options) {
        self.validation_errors = xhr.responseJSON;
        self.render();
      }
    });
  }
});