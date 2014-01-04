App.SortableWidgetsView = Ember.CollectionView.extend JQ.Sortable,
  tagName: "ul"
  classNames: ["add-widgets"]
  revert: true
  itemViewClass: App.DraggableWidgetView.extend
    classNames: ["ui-sortable-item"]
    connectToSortable: "ul.add-widgets.ui-sortable"
    revert: true
