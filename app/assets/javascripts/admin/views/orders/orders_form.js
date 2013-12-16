Shopkick.Views.OrdersForm = Backbone.View.extend({
  initialize: function() {
    this.listenTo(Shopkick.Products, "add", this.render);
    this.listenTo(Shopkick.Customers, "add", this.render);
  },

  validation_errors: [],

  events: {
    "submit" : 'submitForm'
  },

  template: JST['orders/form'],

  tagName: 'form',

  render: function() {
    this.$el.html(this.template({
      order: this.model,
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
        Shopkick.Orders.add(model, { at: 0 });
        Shopkick.OrdersRouter.navigate("/orders", { trigger: true });
      },
      error: function(model, xhr, options) {
        self.validation_errors = xhr.responseJSON;
        self.render();
      }
    });
  }
});