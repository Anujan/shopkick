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
    Shopkick.Orders.fetch({
      success: function() {
          new Shopkick.Routers.Orders();
        }
    });
    Backbone.history.start();
  }
};