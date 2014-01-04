App.SortableWidgetsView = Ember.CollectionView.extend JQ.Sortable,
  tagName: "ul"
  classNames: ["add-widgets"]
  itemViewClass: App.DraggableWidgetView.extend
    classNames: ["ui-sortable-item"]
    connectToSortable: @
