#= require ./widget_view

App.WidgetsListView = Ember.CollectionView.extend JQ.Sortable,
  tagName: "ul"
  classNames: ["add-widgets"]
  itemViewClass: App.WidgetView.extend()
  # JQ.Sortable uiOptions
  revert: true

  # JQ.Sortable uiEvent
  start: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the started Ember view
    droppedViewId = ui.item.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    # Set that the view's content is dragging
    droppedView.content.set("isDragging", true)

  # JQ.Sortable uiEvent
  stop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the stopped Ember view
    droppedViewId = ui.item.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    if droppedView.content?
      # Set that the view's content is not
      droppedView.content.set("isDragging", false)

  # JQ.Sortable uiEvent
  update: (event) ->
    # Save the new display order position
    indexes = {}
    @$(".widget").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
