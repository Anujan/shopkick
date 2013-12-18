Shopkick.Routers.Dashboard = Backbone.Router.extend({
  routes: {
    "" : "dashboard",
    "dashboard" : "dashboard"
  },

  dashboard: function() {
    this._swapView(new Shopkick.Views.Dashboard);
  }
});