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
    new Shopkick.Routers.Orders();
    new Shopkick.Routers.Customers();
    new Shopkick.Routers.Products();
    new Shopkick.Routers.Categories();
    Backbone.history.start();
  }
};