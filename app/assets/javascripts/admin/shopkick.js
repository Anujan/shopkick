window.Shopkick = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Shopkick.$sidenav = $("nav.admin");
    Shopkick.$sidenav.empty();
    new Shopkick.Views.SideNavigation().render().$el.appendTo(Shopkick.$sidenav);
    Shopkick.$rootEl = $('#main-content');
    Shopkick.categoriesCollection = new Shopkick.Collections.Categories();
    Shopkick.productsCollection = new Shopkick.Collections.Products();
    Shopkick.customersCollection = new Shopkick.Collections.Customers();
    Shopkick.ordersCollection = new Shopkick.Collections.Orders();
    Shopkick.dataSeries = new Shopkick.Collections.DataSeries();
    new Shopkick.Routers.Orders();
    new Shopkick.Routers.Customers();
    new Shopkick.Routers.Products();
    new Shopkick.Routers.Categories();
    new Shopkick.Routers.Dashboard();
    Backbone.history.start();
  }
};

$(document).ready(function() {
  if (!Backbone.history.options) {
    window.Shopkick.initialize();
  }
});