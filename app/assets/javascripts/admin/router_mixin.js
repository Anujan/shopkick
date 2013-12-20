_.extend(Backbone.Router.prototype, {
  _swapView: function (newView, options) {
    var options = options ? _.clone(options) : {};
    var swap = function () {
      this._currentView && this._currentView.remove();
      this._currentView = newView;
      if (options.modelId) {
        this._currentView.model = this.collection().get(options.modelId);
      }
      Shopkick.$rootEl.html(newView.render().$el);
    }
    if (this.fetched === false && !this.collection().length) {
      var self = this;
      this.collection().fetch({
        success: function () {
          self.nextUpdate = Date.now() + 120000; //2 minutes
          self.fetched = true;
          swap.call(self);
        }
      });
    } else if (this.nextUpdate && Date.now() > this.nextUpdate) {
      this.collection().fetch();
      swap.call(this);
    } else {
      swap.call(this);
    }
  },
});

_.extend(Backbone.Collection.prototype, {
  filterCollection: function (iterator) {
    return new this.constructor(this.filter(iterator));
  }
});