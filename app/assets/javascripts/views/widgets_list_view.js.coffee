#= require ./widget_view

App.WidgetsListView = Ember.CollectionView.extend JQ.Sortable,
  tagName: "ul"
  classNames: ["add-widgets"]
  revert: true
  itemViewClass: App.WidgetView.extend()
