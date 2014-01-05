App.SortableWidgetsView = Ember.CollectionView.extend JQ.Sortable,
  tagName: "ul"
  classNames: ["add-widgets"]
  revert: true
  # itemViewClass: App.WidgetView.extend()
  # itemViewClass: App.DraggableWidgetView.extend
  #   classNames: ["ui-sortable-item"]
  #   connectToSortable: "ul.add-widgets.ui-sortable"
  #   revert: "invalid"
