Shopkick.Views.GeneralSettings = Backbone.View.extend({
  template: JST['settings/general'],

  tagName: 'form',

  events: {
    "submit": "submitForm"
  },

  updated: false,

  render: function() {
    this.$el.html(this.template({
      profile: Shopkick.profile,
      updated: this.updated
    }));
    self.updated = false;
    return this;
  },

  submitForm: function(event) {
    event.preventDefault();
    var json = $(event.currentTarget).serializeJSON();
    var model = Shopkick.profile;
    var self = this;
    model.save(json, {
      success: function() {
        Backbone.history.navigate("/settings/general", { trigger: true });
        self.updated = true;
        self.render();
      }
    });
  }
});