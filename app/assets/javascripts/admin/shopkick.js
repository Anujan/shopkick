window.Shopkick = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Shopkick.$sidenav = $("nav.admin");
    Shopkick.$sidenav.html("");
    new Shopkick.Views.SideNavigation().render().$el.appendTo(Shopkick.$sidenav);
    Shopkick.$rootEl = $('#main-content');
    Shopkick.categoriesCollection = new Shopkick.Collections.Categories();
    Shopkick.productsCollection = new Shopkick.Collections.Products();
    Shopkick.customersCollection = new Shopkick.Collections.Customers();
    Shopkick.ordersCollection = new Shopkick.Collections.Orders();
    new Shopkick.Routers.Orders();
    new Shopkick.Routers.Customers();
    new Shopkick.Routers.Products();
    new Shopkick.Routers.Categories();
    Backbone.history.start();
  }
};