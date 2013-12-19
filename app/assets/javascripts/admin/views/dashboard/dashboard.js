Shopkick.Views.Dashboard = Backbone.View.extend({
  initialize: function() {
    this.listenTo(Shopkick.dataSeries, 'add', this.order_day_chart);
  },

  template: JST['dashboard/index'],

  render: function() {
    this.$el.html(this.template());
    Shopkick.dataSeries.fetch();
    return this;
  },

  order_day_chart: function() {
    var data = [['Date', 'Total Price']];
    var values = [];
    var self = this;
    values = Shopkick.dataSeries.map(function(model) {
      return model.point();
    });
    data = data.concat(values);
    var view = new Backbone.GoogleChart({
      chartType: 'LineChart',
      dataTable: data,
      options: {'title': 'ORDERS BY DAY', 'pointSize': 5}
    });
    self.$("#order-day-chart").html(view.render().$el);
  }
});