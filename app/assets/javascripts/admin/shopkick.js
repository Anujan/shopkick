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
    Shopkick.Orders.fetch({ success: function() {
      Shopkick.Customers = new Shopkick.Collections.Customers();
      Shopkick.Customers.fetch({ success: function() {
        Shopkick.Products = new Shopkick.Collections.Products();
        Shopkick.Products.fetch({ success: function() {
          Shopkick.OrdersRouter = new Shopkick.Routers.Orders();
          Shopkick.CustomersRouter = new Shopkick.Routers.Customers();
          Backbone.history.start();
        }});
      }});
    }});
  }
};