_.extend(Backbone.Router.prototype, {
  _swapView: function (newView, options) {
    var options = options ? _.clone(options) : {};
    var swap = function () {
      this._currentView && this._currentView.remove();
      this._currentView = newView;
      if (options.modelId) {
        this._currentView.model = this.collection().get(options.modelId);
      }
      this._currentView.listenTo(this.collection(), "sync", this._currentView.render);
      Shopkick.$rootEl.html(newView.render().$el);
    }
    var fetchCollection = function() {
      var self = this;
      this.collection().fetch({
        success: function () {
          self.nextUpdate = Date.now() + 120000; //2 minutes
          self.fetched = true;
        }
      });
    }
    if ((this.fetched === false && !this.collection().length) ||
    (this.nextUpdate && Date.now() > this.nextUpdate)) {
      fetchCollection.call(this);
    }
    swap.call(this);
  }
});

_.extend(Backbone.Collection.prototype, {
  filterCollection: function (iterator) {
    return new this.constructor(this.filter(iterator));
  }
});