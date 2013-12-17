Shopkick.Views.TableFilter = Backbone.View.extend({
  initialize: function(options) {
    this.collection = options.collection;
		this.listenTo(this.collection, "add", this.render);
    this.listenTo(this.collection, "change", this.render);
    this.listenTo(this.collection, "remove", this.render);
    this.searchAttributes = options.searchAttributes || ["title"];
  },

  tagName: 'input',

  events: {
    "keyup": 'filter'
  },

  attributes: {
    "type": "text",
    "placeholder": "Start typing to filter the table...",
    "id": "filter"
  },

  render: function() {
    return this;
  },

  filter: function(event) {
    this.trigger("filter");
  },

  filteredCollection: function() {
    var query = this.$el.val();
    if (!query) {
      return this.collection;
    } else {
      var collection = new this.collection.constructor(
        this.collection.filter(this.filterIterator.bind(this))
      );
      return collection;
    }
  },

  filterIterator: function (model) {
    var query = this.$el.val();
    var pattern = new RegExp(query, "gi");
    var searchAttrs = _.clone(this.searchAttributes);
    var attrs = _.map(searchAttrs, function(searchAttr) {
      return model.get(searchAttr);
    });
    return _(attrs).any(function(attribute) {
      return attribute.match(pattern);
    });
  }
});