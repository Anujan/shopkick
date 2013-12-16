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
    Shopkick.Categories = new Shopkick.Collections.Categories();
    Shopkick.Customers = new Shopkick.Collections.Customers();
    Shopkick.Products = new Shopkick.Collections.Products();
    Shopkick.Customers.fetch({ success: function() {
      Shopkick.Products.fetch({ success: function() {
        Shopkick.Categories.fetch({ success: function() {
          Shopkick.Orders.fetch({
            success: function() {
              Shopkick.OrdersRouter = new Shopkick.Routers.Orders();
              Shopkick.CustomersRouter = new Shopkick.Routers.Customers();
              Shopkick.ProductsRouter = new Shopkick.Routers.Products();
              Backbone.history.start();
            }
          });
        }});
      }});
    }});
  }
};