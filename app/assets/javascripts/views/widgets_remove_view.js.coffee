App.WidgetsRemoveView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-remove"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_remove"]
  # JQ.Droppable uiOptions
  accept: ".existing-widget"

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetActive: ( ->
    if Ember.isEmpty(@get("dragContext"))
      return null
    else
      "drop-target-active"
  ).property("dragContext")

  # JQ.Droppable uiEvent
  drop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the dropped Ember view
    droppedViewId = ui.draggable.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    # Destroy the dropped view's content
    droppedView.content.deleteRecord()
    droppedView.content.save()
