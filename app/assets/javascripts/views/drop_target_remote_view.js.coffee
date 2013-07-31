App.DropTargetRemoveView = Ember.View.extend App.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-remove"]
  classNameBindings: ["dropTargetActive"]
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

  # Overrides App.Droppable#drop
  drop: (event) ->
    # Get the view that was dropped
    viewId = event.originalEvent.dataTransfer.getData("Text")
    view = Ember.View.views[viewId]

    # Destroy the content that was dropped
    view.content.deleteRecord()
    view.content.save()

    # Call App.Droppable#drop
    @_super event
