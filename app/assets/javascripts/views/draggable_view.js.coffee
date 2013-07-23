G5ClientHub.DraggableView = Ember.View.extend G5ClientHub.Draggable,
  tagName: "span"

  # Overrides G5ClientHub.Draggable#dragStart
  dragStart: (event) ->
    # Let the controller know this view is dragging
    @set "content.isDragging", true
    # Call G5ClientHub.Draggable#dragStart
    @_super event

  # Overrides G5ClientHub.Draggable#dragEnd
  dragEnd: (event) ->
    # Let the controller know this view is done dragging
    @set "content.isDragging", false
    # Call G5ClientHub.Draggable#dragEnd
    @_super event
