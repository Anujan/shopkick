Shopkick.Models.DataPoint = Backbone.Model.extend({
  initialize: function(attributes) {
    this.set({
      x: attributes.date,
      y: attributes.total_price
    })
  },

  point: function() {
    return [new Date(this.get('x')), Number(this.get('y'))];
  }
});

Shopkick.Collections.DataSeries = Backbone.Collection.extend({
  model: Shopkick.Models.DataPoint,
  url: "/admin"
});