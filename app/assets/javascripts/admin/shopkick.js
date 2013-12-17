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
    Shopkick.Categories = new Shopkick.Collections.Categories();
    Shopkick.Products = new Shopkick.Collections.Products();
    Shopkick.Customers = new Shopkick.Collections.Customers();
    Shopkick.Orders = new Shopkick.Collections.Orders();
    Shopkick.OrdersRouter = new Shopkick.Routers.Orders();
    Shopkick.CustomersRouter = new Shopkick.Routers.Customers();
    Shopkick.ProductsRouter = new Shopkick.Routers.Products();
    Shopkick.CategoriesRouter = new Shopkick.Routers.Categories();
    Backbone.history.start();
  }
};