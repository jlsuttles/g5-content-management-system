App.DraggableView = Ember.View.extend App.Draggable,
  tagName: "span"

  # Overrides App.Draggable#dragStart
  dragStart: (event) ->
    # Let the controller know this view is dragging
    @set "content.isDragging", true
    # Call App.Draggable#dragStart
    @_super event

  # Overrides App.Draggable#dragEnd
  dragEnd: (event) ->
    # Let the controller know this view is done dragging
    @set "content.isDragging", false
    # Call App.Draggable#dragEnd
    @_super event
