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
    Shopkick.Orders = new Shopkick.Collections.Orders();
    Shopkick.Orders.fetch();
    Shopkick.Customers = new Shopkick.Collections.Customers();
    Shopkick.Customers.fetch();
    Shopkick.Products = new Shopkick.Collections.Products();
    Shopkick.Products.fetch();
    Shopkick.OrdersRouter = new Shopkick.Routers.Orders();
    Backbone.history.start();
  }
};