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
    if (!this.fetched && this.fetched !== void 0) {
      var self = this;
      this.collection().fetch({
        success: function () {
          self.fetched = true;
          swap.call(self);
        }
      });
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