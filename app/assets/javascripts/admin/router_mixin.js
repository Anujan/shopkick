_.extend(Backbone.Router.prototype, {
  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    Shopkick.$rootEl.html(newView.render().$el);
  },
});