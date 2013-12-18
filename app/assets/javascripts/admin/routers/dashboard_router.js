Shopkick.Routers.Dashboard = Backbone.Router.extend({
  routes: {
    "" : "dashboard",
    "dashboard" : "dashboard",
    "settings/general" : "general_settings"
  },

  collection: function() {
    return Shopkick.profile;
  },

  fetched: false,

  dashboard: function() {
    this._swapView(new Shopkick.Views.Dashboard);
  },

  general_settings: function() {
    this._swapView(new Shopkick.Views.GeneralSettings);
  }


});