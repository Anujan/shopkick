Shopkick.Routers.Dashboard = Backbone.Router.extend({
  routes: {
    "" : "dashboard",
    "dashboard" : "dashboard"
  },

  dashboard: function() {
    var data = [['Date', 'Total Price']];
    var values = [];
    var self = this;
    Shopkick.dataSeries.fetch({
      success: function() {
        values = Shopkick.dataSeries.map(function(model) {
          return model.point();
        });
        data = data.concat(values);
        self._swapView(new Backbone.GoogleChart({
          chartType: 'LineChart',
          dataTable: data,
          options: {'title': 'ORDERS BY DAY', 'pointSize': 5}
        }));
      },
      wait: true
    });
  }
});