App.WidgetsRemoveView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-remove"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_remove"]
  helpText: null

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetActive: ( ->
    if Ember.isEmpty(@get("dragContext"))
      @set "helpText", "Drag here to remove"
      return null
    else
      @set "helpText", "Drag here to remove"
      "drop-target-active"
  ).property("dragContext")

  drop: (event, ui) ->
    # Get the view that was dropped
    viewId = ui.draggable.attr("id")
    view = Ember.View.views[viewId]

    # Destroy the content that was dropped
    view.content.deleteRecord()
    view.content.save()
